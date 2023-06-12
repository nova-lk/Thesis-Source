clear all;
close all;

%key --> 192-bit integer
priv_key = 'ef235aacf90d9f4aadd8c92e4b2562e1d9eb97f0df9ba3b5';
% priv_key_hex = binaryVectorToHex(logical(priv_key_bin));

%Hex to Bin Conversion
priv_key_bin = double(hexToBinaryVector(priv_key));


%create a zero matrix to fill the data subcarriers. 192 ---> 234
fill = zeros(1,21);

%add zeros to two ends to get 234 bits
binVal = [fill priv_key_bin fill];

%calculate no of bits
totalbits = length(binVal);

%creating repeating symbols
tx = repmat(binVal,1,1000);

nFFT = 256; % fft size
nDSC = 234; % number of data subcarriers
nBitPerSym = 234; % number of bits per OFDM symbol
nSym = 1000; %number of symbols
EbN0dB = [0:0.5:25]; % bit to noise ratio
EsN0dB = EbN0dB + 10*log10(nDSC/nFFT) + 10*log10(256/272); % converting to symbol to noise ratio

for ii = 1:length(EbN0dB)
    
    % Transmitter
    
    ipBit = tx; 
    %pskmod(x,M) modulates the input signal, x, using phase shift keying (PSK) with modulation order M.
    ipMod = pskmod(ipBit,2);
    % BPSK modulation 0 --> -1, 1 --> +1
    ipMod = reshape(ipMod,nBitPerSym,nSym).'; % grouping into multiple symbols

    %Assigning modulated symbols to 256 subcarriers
    %6sideband + 26data + 1pilot + 26data + 1pilot + 26data + 1pilot + 26data + 1pilot + 13data + 3DC + 13data + 1pilot + 26data + 1pilot + 26data + 1pilot + 26data + 1pilot + 26data + 5
    xF = [zeros(nSym,6) ipMod(:,[1:26]) zeros(nSym,1) ipMod(:,[27:52]) zeros(nSym,1) ipMod(:,[53:78]) zeros(nSym,1) ipMod(:,[79:104]) zeros(nSym,1) ipMod(:,[105:117]) zeros(nSym,3) ipMod(:,[118:130]) zeros(nSym,1) ipMod(:,[131:156]) zeros(nSym,1) ipMod(:,[157:182]) zeros(nSym,1) ipMod(:,[183:208]) zeros(nSym,1) ipMod(:,[209:234]) zeros(nSym,5)] ;
    % Taking FFT, the term (nFFT/sqrt(nDSC)) is for normalizing the power of transmit symbol to 1 
    xt = (nFFT/sqrt(nDSC))*ifft(fftshift(xF.')).';

    % Appending cylic prefix of 16bits
    xt = [xt(:,[241:256]) xt];

    % Concatenating multiple symbols to form a long vector
    % new bit length --> 256+16 = 272
    xt = reshape(xt.',1,nSym*272);

    % Gaussian noise of unit variance, 0 mean
    nt = 1/sqrt(2)*[randn(1,nSym*272) + j*randn(1,nSym*272)];

    % Adding noise, the term sqrt(272/256) is to account for the wasted energy due to cyclic prefix
    yt = sqrt(272/256)*xt + 10^(-EsN0dB(ii)/20)*nt;

    
    % Receiver
    
    yt = reshape(yt.',272,nSym).'; % formatting the received vector into symbols
    yt = yt(:,[17:272]); % removing cyclic prefix ---> from 1 to 16

    % converting to frequency domain
    yF = (sqrt(nDSC)/nFFT)*fftshift(fft(yt.')).'; 
    %6sideband + 26data + 1pilot + 26data + 1pilot + 26data + 1pilot + 26data + 1pilot + 13data + 3DC + 13data + 1pilot + 26data + 1pilot + 26data + 1pilot + 26data + 1pilot + 26data + 5
    yMod = [yF(:,7:32) yF(:,34:59) yF(:,61:86) yF(:,88:113) yF(:,115:127) yF(:,131:143) yF(:,145:170) yF(:,172:197) yF(:,199:224) yF(:,226:251)];
   
    ser_data_1 = reshape(yMod.',nBitPerSym*nSym,1);
    demod_Data = pskdemod(ser_data_1,2); %demodulating the data
    out2=[de2bi(demod_Data)]';

    % counting the errors
    nErr(ii) = size(find(out2 - ipBit),2);
   
   
    recovered_data =reshape(out2.',nBitPerSym,nSym);
    count1=0;
    count2=0;
    
    %recover data from each OFDM symbol
    for l=1:1:nSym
  
        recovered = recovered_data(:,l).';
        
        if(recovered==binVal)
            count1=count1 + 1; 
        else
            count2=count2 + 1; 
        end
        
        bitErrorMat = bitxor(recovered,binVal);
        errorbitcount = sum(bitErrorMat(:) == 1);    
        
    end
    
OFDM_COUNT_BPSK_AWGN(ii)=count1/(count1+count2); 
BIT_ERROR_BPSK_AWGN(ii)=1-(errorbitcount/totalbits); 

end

%save data as a .mat file
save('uncoded_OFDM_BPSK_AWGN.mat','OFDM_COUNT_BPSK_AWGN','BIT_ERROR_BPSK_AWGN','EbN0dB');


simBer = nErr/(nSym*nBitPerSym);
theoryBer = (1/2)*erfc(sqrt(10.^(EbN0dB/10)));

close all; figure
semilogy(EbN0dB,theoryBer,'bs-','LineWidth',2);
hold on
semilogy(EbN0dB,simBer,'mx-','LineWidth',2);
%axis([0 10 10^-5 1])
grid on
legend('theory', 'simulation');
xlabel('Eb/No, dB')
ylabel('Bit Error Rate')
title('Bit error probability curve for BPSK using OFDM')



