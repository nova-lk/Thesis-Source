clear all;
close all;


% load uncoded_OFDM_BPSK_AWGN.mat
load uncoded_OFDM_BPSK_Rayleigh.mat
% load uncoded_OFDM_BPSK_Rician.mat

% load uncoded_OFDM_QPSK_AWGN.mat
load uncoded_OFDM_QPSK_Rayleigh.mat
% load uncoded_OFDM_QPSK_Rician.mat


figure, plot(EbN0dB,OFDM_COUNT_BPSK_Rayleigh,'k-o', EbN0dB,OFDM_COUNT_QPSK_Rayleigh,'k-^');

grid on, xlabel('Eb/No'), ylabel('Key Recovery Probability');

legend('BPSK', 'QPSK','Location','best')