clear all;
close all;

% 
% load uncoded_OFDM_BPSK_AWGN.mat
% load uncoded_OFDM_BPSK_Rayleigh.mat
% load uncoded_OFDM_BPSK_Rician.mat

load uncoded_OFDM_QPSK_AWGN.mat
load uncoded_OFDM_QPSK_Rayleigh.mat
load uncoded_OFDM_QPSK_Rician.mat


figure, plot(EbN0dB, OFDM_COUNT_QPSK_AWGN,'k-o',EbN0dB,OFDM_COUNT_QPSK_Rayleigh,'k-d',EbN0dB,OFDM_COUNT_QPSK_Rician,'k-^');

grid on, xlabel('Eb/No'), ylabel('Key Recovery Probability');

legend('AWGN', 'Rayleigh','Rician','Location','best')