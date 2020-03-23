function QAMTxRx(v,N,L,Fs)
% Compute power spectrum of received signal in simplified 16 QAM model
% Inputs:
%   v  - EbNodB                  (default = 80)
%   N  - Modulation order        (default = 16)
%   L  - sinusoid segment length (default = 625)
%   f  - sinusoid frequency      (default = 100 MHz)

% This function requires Communications Toolbox(TM)

% Copyright 2019 The MathWorks, Inc.

% Defaults
if nargin < 1
    % Segment length
    v = 80;
end
if nargin < 2
    % Segment length
    N = 16;
end
if nargin < 3
    % Segment length
    L = 625;
end
if nargin < 4
    % Sample rate
    Fs = 100e6;
end
% Common Spectrum Analyzer Settings
NAvg = 10;
Ylim = [-80 20];

% Setup pulse shaping and matched filter
beta = 0.45; % Rolloff
OS = 4;
b = rcosdesign(beta,6, OS,'sqrt');
txfilt = dsp.FIRInterpolator(OS,b);
rxfilt = dsp.FIRDecimator(OS,b);

% Setup AWGN channel
channel = comm.AWGNChannel('EbNo',v,...
    'BitsPerSymbol',4,'SamplesPerSymbol',OS);

% Create scopes
rectWinSA = dsp.SpectrumAnalyzer('SampleRate',Fs, ...    
    'FrequencyResolutionMethod','WindowLength', ...
    'WindowLength',L*OS, ...
    'Window','Rectangular', ...
    'SpectralAverages',NAvg, ...
    'Title','Rectangular Windowed Spectrum',...    
    'FFTLengthSource','Property',...
    'FFTLength',L*OS,...
    'YLimits',Ylim);
kaiserSA = dsp.SpectrumAnalyzer('SampleRate',Fs, ...    
    'FrequencyResolutionMethod','WindowLength', ...
    'WindowLength',L*OS, ...
    'Window','Kaiser', ...
    'SpectralAverages',NAvg, ...
    'Title','Kaiser Windowed Spectrum',...    
    'FFTLengthSource','Property',...
    'FFTLength',L*OS,...
    'YLimits',Ylim);
filterBankSA = dsp.SpectrumAnalyzer('SampleRate',Fs, ...
    'Method','Filter bank', ...    
    'FrequencyResolutionMethod','NumFrequencyBands', ...
    'FFTLengthSource','Property', ...
    'FFTLength',L*OS, ...
    'SpectralAverages',NAvg, ...
    'Title','Filter Bank Spectrum',...    
    'YLimits',Ylim);

% Create constellation diagram
refC = qammod(0:N-1,N);
D = max(abs(refC));
constdiag = comm.ConstellationDiagram('ReferenceConstellation',refC,...
    'XLimits',[-D D],'YLimits',[-D D]);

tic
while toc < 90
    % Run for 90 seconds
    s = randi([0,N-1],L,1); % Symbols transmitted
    m = qammod(s,N);        % Modulated symbols
    t = txfilt(m);          % Pulse-sghaped symbols
    
    r = channel(t);         % AWGN channel
    
    % Compute and plot received spectrum
    rectWinSA(r);
    kaiserSA(r);
    filterBankSA(r);
    
    w = rxfilt(r);         % Matched filter signal
    constdiag(w);          % Plot constellation    
end
    
    

