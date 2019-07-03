function response = stimulus_response_scalar(timeseries, timestamps, stim_onsetoffsetid, varargin)
% STIMULUS_RESPONSE_SUMMARY - compute stimulus responses to stimuli
% 
% RESPONSE = STIMULUS_RESPONSE_SCALAR(TIMESERIES, TIMESTAMPS, STIM_ONSETOFFSETID, ...)
%
% Inputs:
%   TIMESERIES is a 1xT array of the data values of the thing exhibiting the response, such as
%       a voltage signal, calcium dF/F signal, or spike signals (1s).
%   TIMESTAMPS is a 1xT array of the occurrences of the signals in TIMESERIES
%   STIM_ONSETOFFSETID is a variable that describes the stimulus history. Each row should
%       contain [stim_onset_time stim_offset_time stimid] where the times are in units of TIMESTAMPS (s).
% 
% Computes a structure RESPONSE with fields:
% Field name:                   | Description:
% ------------------------------------------------------------------------
% stimid                        | The stimulus id of each stimulus observed; there will be 1 value of stimid
%                               |   for each stimulus presentation (so stimid values may repeat many times)
% response                      | The scalar response to each stimulus response.
% control_response              | The scalar response to the control stimulus for each stimulus
% controlstimnumber             | The stimulus number used as the control stimulus for each stimulus
% parameters                    | A structure with the parameters used in the calculation (described below)
%
% The behavior of the function can be modified by name/value pairs:
% Parameter (default value)     | Description: 
% ------------------------------------------------------------------------
% freq_response (0)             | The frequency response to measure using FFT of TIMESERIES. Can be
%                               |     0 (to use the mean response), or a number corresponding
%                               |     to the frequency to analyze. Can also be a vector
%                               |     the same size as the number of stimuli to indicate
%                               |     the frequency to be used for each stimulus (freq_response(stimid(i)).
%                               |     For example, to compute the response at the fundamental stimulus
%                               |     frequency (F1) when that frequency is 1 Hz, pass 1 for 'freq_response'.
% control_stimid ([])           | Use this to pass the identity (or identities) of a 'blank' stimulus
%                               |     (some sort of control stimulus; in vision, this is often presenting
%                               |     a blank screen for same duration as the other stimuli.)
% prestimulus_time ([])         | Calculate a baseline using a certain amount of TIMESERIES signal during
%                               |     the pre-stimulus time given here. 
% prestimulus_normalization ([])| Normalize the stimulus response based on the prestimulus measurement.
%                               | [] or 0) No normalization 
%                               |       1) Subtract: Response := Response - PrestimResponse
%                               |       2) Fractional change Response:= ((Response-PrestimResponse)/PrestimResponse)
%                               |       3) Divide: Response:= Response ./ PreStimResponse
% isspike (see right)           | 0/1 Is the signal a spike process? If so, timestamps correspond to spike events.
% spiketrain_dt (0.001)         | Resolution to use for spike train reconstruction if computing Fourier transform
%

freq_response = 0;
control_stimid = [];

prestimulus_time = [];
prestimulus_normalization = [];

isspike = 0;
spiketrain_dt = 0.001;

assign(varargin{:});

parameters = workspace2struct();
parameters = rmfield(parameters,{'varargin','timeseries','timestamps','stim_onsetoffsetid'});

stimid = stim_onsetoffsetid(:,3);
response = [];
control_response = [];

sample_rate = 0;

if numel(timestamps)>1,
	sample_rate = 1./median(diff(timestamps));
end;


controlstimnumber = findcontrolstimulus(stimid, control_stimid);

if ~isempty(prestimulus_normalization),
	if ischar(prestimulus_normalization),
		prestimulus_normalization = lower(prestimulus_normalization);
	end
end;

for i=1:numel(stimid),
	% works for both regularly sampled and irregularly sampled time data
	stimulus_samples = find(timestamps>=stim_onsetoffsetid(i,1) & timestamps<=stim_onsetoffsetid(i,2)); 

	if ~isempty(prestimulus_time),
		prestimulus_samples = find(timestamps>=stim_onsetoffsetid(i,1)-prestimulus_time & timestamps<stim_onsetoffsetid(i,1)); 
	else,
		prestimulus_samples = [];
	end;

	% now calculate response

	freq_response_here = freq_response;
	if numel(freq_response)>1,
		freq_response_here = freq_response_here(stimid(i));
	end;

	if freq_response_here==0,
		if ~isspike,
			response_here = nanmean(timeseries(stimulus_samples));
		else,
			response_here = sum(timeseries(stimulus_samples))/diff(stim_onsetoffsetid(i,[1 2]));
		end;
		if ~isempty(prestimulus_time),
			if ~isspike,
				prestimulus_here = nanmean(timeseries(prestimulus_samples));
			else,
				prestimulus_here = sum(timeseries(prestimulus_samples))/diff(stim_onsetoffsetid(i,[1 2]));
			end;
		else,
			prestimulus_here = [];
		end;
	else,
		if ~isspike,
			response_here = fouriercoeffs_tf2( timeseries(stimulus_samples), freq_response_here, sample_rate);
		else,
			if numel(stimulus_samples)>0,
				response_here = sum(exp(-sqrt(-1)*2*pi*freq_response_here*(timestamps(stimulus_samples)-stim_onsetoffsetid(i,1))));
			else,
				response_here = 0;
			end;
		end;
		if ~isempty(prestimulus_time),
			if ~isspike,
				prestimulus_here = fouriercoeffs_tf2(timeseries(prestimulus_samples), freq_response_here, sample_rate);
			else,
				if numel(prestimulus_samples)>0,
					prestimulus_here = sum(exp(-sqrt(-1)*2*pi*freq_response_here*(timestamps(prestimulus_samples)-stim_onsetoffsetid(i,1)-prestimulus_time)));
				else,
					prestimulus_here = 0;
				end;
			end;
		end;
	end;

	if ~isempty(prestimulus_normalization),
		switch prestimulus_normalization,
			case {0,'none'},
				% do nothing,
			case {1,'subtract'} % subtract
				response_here = response_here - prestimulus_here;
			case {2,'fractional'},
				response_here = (response_here - prestimulus_here)./prestimulus_here;
			case {3,'divide'},
				response_here = response_here./prestimulus_here;
		end; % switch
	end;

	response(i) = response_here;
end

if ~isempty(controlstimnumber),
	control_response = response(controlstimnumber);
end

response = var2struct('stimid','response','control_response','controlstimnumber','parameters');
