clear all;
close all;

count1=0;
count2=0;
count3=0;
count4=0;
   
%required no. of key components
%keys_req = 10; 
components = [10:1:30];

%key --> 192-bit integer
priv_key = 'ef235aacf90d9f4aadd8c92e4b2562e1d9eb97f0df9ba3b5';
% priv_key_hex = binaryVectorToHex(logical(priv_key_bin));

%Hex to Bin Conversion
priv_key_bin = double(hexToBinaryVector(priv_key));


%create a zero matrix to fill the data subcarriers. 192 ---> 234
fill = zeros(1,21);

%add zeros to two ends to get 234 bits
binVal = [fill priv_key_bin fill];

totalbits = length(binVal);

tx = repmat(binVal,1,60);
 
%tx = repmat(tx,1,2500);

nFFT = 256; % fft size
nDSC = 234; % number of data subcarriers
nBitPerSym = 234; % number of bits per OFDM symbol (same as the number of subcarriers for BPSK)
nSym = 30; %nSym --> number of symbols
EbN0dB = [5]; % bit to noise ratio
EsN0dB = EbN0dB + 10*log10(nDSC/nFFT) + 10*log10(256/272)+10*log10(2); % converting to symbol to noise ratio

for xx = 1:length(components)

for ii = 1:1000

    % Transmitter
    %ipBit = rand(1,nBitPerSym*nSym) > 0.5; % random 1's and 0's
    ipBit = tx; 
    %pskmod(x,M) modulates the input signal, x, using phase shift keying (PSK) with modulation order M.
%     ipMod = pskmod(ipBit,2);
    data_bits=bi2de([reshape(ipBit,2, length(ipBit)/2)]'); 
     mod_data = pskmod((data_bits),4,0,'bin');
     ipMod = reshape(mod_data,nBitPerSym,nSym).'; 

    %Assigning modulated symbols to 256 subcarriers
    %6sideband + 26data + 1pilot + 26data + 1pilot + 26data + 1pilot + 26data + 1pilot + 13data + 3DC + 13data + 1pilot + 26data + 1pilot + 26data + 1pilot + 26data + 1pilot + 26data + 5
    xF = [zeros(nSym,6) ipMod(:,[1:26]) zeros(nSym,1) ipMod(:,[27:52]) zeros(nSym,1) ipMod(:,[53:78]) zeros(nSym,1) ipMod(:,[79:104]) zeros(nSym,1) ipMod(:,[105:117]) zeros(nSym,3) ipMod(:,[118:130]) zeros(nSym,1) ipMod(:,[131:156]) zeros(nSym,1) ipMod(:,[157:182]) zeros(nSym,1) ipMod(:,[183:208]) zeros(nSym,1) ipMod(:,[209:234]) zeros(nSym,5)] ;
    %xF = [zeros(nSym,6) ipMod(:,[1:nBitPerSym/2]) zeros(nSym,1) ipMod(:,[nBitPerSym/2+1:nBitPerSym]) zeros(nSym,5)] ;
    % Taking FFT, the term (nFFT/sqrt(nDSC)) is for normalizing the power of transmit symbol to 1 
    xt = (nFFT/sqrt(nDSC))*ifft(fftshift(xF.')).';

    % Appending cylic prefix of 16bits from tail to head
    xt = [xt(:,[241:256]) xt];
   
   
   % multipath channel
   nTap = 10;
   ht = 1/sqrt(2)*1/sqrt(nTap)*(randn(nSym,nTap) + 1i*randn(nSym,nTap));
   
   % computing and storing the frequency response of the channel, for use at recevier
   hF = fftshift(fft(ht,256,2));

   % convolution of each symbol with the random channel
   for jj = 1:nSym
      xht(jj,:) = conv(ht(jj,:),xt(jj,:));
   end
   xt = xht;
   
   
   

   % Concatenating multiple symbols to form a long vector
   xt = reshape(xt.',1,nSym*(272+nTap-1));


   % Gaussian noise of unit variance, 0 mean
   nt = 1/sqrt(2)*[randn(1,nSym*(272+nTap-1)) + 1i*randn(1,nSym*(272+nTap-1))];
   %h = 1/sqrt(2)*[randn(1,nSym*80) + 1i*randn(1,nSym*80)]; % Rayleigh channel

   % Adding noise, the term sqrt(80/64) is to account for the wasted energy due to cyclic prefix
   yt = sqrt(272/256)*(xt) + 10^(-EsN0dB/20)*nt;

   %yt=yt./h;
   % Receiver
    yt = reshape(yt.',(272+nTap-1),nSym).'; % formatting the received vector into symbols
    yt = yt(:,[17:272]); % removing cyclic prefix ---> from 1 to 16

   % converting to frequency domain
   yF = (sqrt(nDSC)/nFFT)*fftshift(fft(yt.')).'; 
   yF = yF./hF;
   %6sideband + 26data + 1pilot + 26data + 1pilot + 26data + 1pilot + 26data + 1pilot + 13data + 3DC + 13data + 1pilot + 26data + 1pilot + 26data + 1pilot + 26data + 1pilot + 26data + 5
   yMod = [yF(:,7:32) yF(:,34:59) yF(:,61:86) yF(:,88:113) yF(:,115:127) yF(:,131:143) yF(:,145:170) yF(:,172:197) yF(:,199:224) yF(:,226:251)];
   
    ser_data_1 = reshape(yMod.',nBitPerSym*nSym,1);
    demod_Data = pskdemod(ser_data_1,4,0,'bin'); %demodulating the data
    out2=[de2bi(demod_Data)]';
    output =out2(:);

    % converting modulated values into bits
    % ipBitHat = (ipModHat+1)/2;
    % ipBitHat = reshape(ipBitHat.',nBitPerSym*nSym,1).';

    % counting the errors
%     nErr(ii) = size(find(out2 - ipBit),2);
    nErr(ii) = size(find(output.' - ipBit),2);
   
   
%     recovered_data =reshape(out2.',nBitPerSym,nSym);
    recovered_data =reshape(output.',2*nBitPerSym,nSym);

   %for l=1:2:nSym-1
    for l=1:1:nSym
%         rx =[bin2dec(num2str(recovered_data(1:16,l)).') bin2dec(num2str(recovered_data(17:32,l)).') bin2dec(num2str(recovered_data(33:48,l)).')].';
%         %rx =[bin2dec(num2str(recovered_data(1:16,l)).') bin2dec(num2str(recovered_data(17:32,l)).') bin2dec(num2str(recovered_data(33:48,l)).') bin2dec(num2str(recovered_data(1:16,l+1)).') bin2dec(num2str(recovered_data(17:32,l+1)).') bin2dec(num2str(recovered_data(33:48,l+1)).')].';
%         if(sum(rx==d(1:3,2))>=2)|| (sum(rx==d(4:6,2))>=2)
%             count1=(count1)+1; 
%         else
%             count2=(count2)+1; 
%         end
        
        recovered = recovered_data(:,l).';
        
        if((recovered(:,1:234)==binVal)|(recovered(:,235:468)==binVal))
            count1=count1 + 1; 
        else
            count2=count2 + 1; 
        end
             
        %bitErrorMat = bitxor(recovered(:,1:234),binVal);
        %errorbitcount = sum(bitErrorMat(:) == 1);
    end
    
    if (count1 >= components(xx))
            count3 = count3 + 1;
        else
            count4 = count4 + 1;
    end
    
    count1=0;
    count2=0;

end

Key_Components_5(xx)=count3/(count3+count4); 

count3=0;
count4=0;

end

save('uncoded_Key_Component_5.mat','Key_Components_5','components');


