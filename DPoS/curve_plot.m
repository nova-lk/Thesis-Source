clear all;
close all;


load uncoded_OFDM_BPSK_AWGN.mat
load uncoded_OFDM_BPSK_Rayleigh.mat
load uncoded_OFDM_BPSK_Rician.mat

load uncoded_OFDM_QPSK_AWGN.mat
load uncoded_OFDM_QPSK_Rayleigh.mat
load uncoded_OFDM_QPSK_Rician.mat


figure, plot(EbN0dB, OFDM_COUNT_BPSK_AWGN,'r-o',EbN0dB,OFDM_COUNT_BPSK_Rayleigh,'k-o',EbN0dB,OFDM_COUNT_BPSK_Rician,'b-o',EbN0dB,OFDM_COUNT_QPSK_AWGN,'r-^',EbN0dB,OFDM_COUNT_QPSK_Rayleigh,'k-^',EbN0dB,OFDM_COUNT_QPSK_Rician,'b-^');

grid on, xlabel('Eb/No'), ylabel('Key Recovery Probability');

legend('BPSK, AWGN', 'BPSK, Rayleigh','BPSK, Rician','QPSK, AWGN','QPSK, Rayleigh','QPSK, Rician','Location','best')