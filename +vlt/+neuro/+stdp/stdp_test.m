function stdp_test
% STDP_TEST Test performance of STPD_APPLY and STDP_TRIPLET_APPLY
%
%  Performs a test of vlt.neuro.stdp.stdp_apply and vlt.neuro.stdp.stdp_triplet_apply
%  using data from vlt.neuro.stdp.sjostrom_freq_stdp.
%
%  See also: vlt.neuro.stdp.stdp_apply, STDP_TRIPLET
%

A = vlt.neuro.stdp.sjostrom_freq_stdp;

dweight = [];
dweight_triplet = [];

dweight2 = [];
dweight2_triplet = [];

for i=1:size(A,2)
	% pre before post
	[pre,post] = vlt.neuro.stdp.sjostrom_spiketrain(0.010,A(i,1),60);
	dweight(end+1) = vlt.neuro.stdp.stdp_apply(pre,post);
	dweight_triplet(end+1) = vlt.neuro.stdp.stdp_triplet_apply(pre,post);

	% post before pre
	[pre,post] = vlt.neuro.stdp.sjostrom_spiketrain(-0.010,A(i,1),60);
	dweight2(end+1) = vlt.neuro.stdp.stdp_apply(pre,post);
	dweight2_triplet(end+1) = vlt.neuro.stdp.stdp_triplet_apply(pre,post);
end;

figure;
plot(A(:,1),dweight,'k-');
hold on;
plot(A(:,1),dweight_triplet,'k--');


plot(A(:,1),dweight2,'b-');
plot(A(:,1),dweight2_triplet,'b--');

h = errorbar(A(:,1),A(:,2),A(:,3),'ko');
h = errorbar(A(:,1),A(:,4),A(:,5),'bo');

xlabel('Frequency');
ylabel('Change in weight');
box off;
legend('Pre<Post doublet','Pre<Post triplet','Pre>Post doublet','Pre>Post triplet','Pre<Post data','Pre>Post data','Location','NorthWest');
