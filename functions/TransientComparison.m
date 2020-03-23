function TransientComparison(L,Fs,v)
% Compute power spectrum of two sinusoids close to each other
% Inputs:
%   L    - sinusoid segment length (default = 1024)
%   NAvg - Number of averages      (default = 20) 
%   f    - sinusoid frequency      (default = 60 MHz)
%   Fs   - sample rate             (default = 500 MHz)
%   v    - noise variance          (default = 0.1)

% This function requires DSP System Toolbox(TM)

% Copyright 2019 The MathWorks, Inc.

% Defaults
if nargin < 1
    % Segment length
    L = 1024;
end
if nargin < 2
    % Sample rate
    Fs = 500e6;
end
if nargin < 3
    % Noise variance
    v = 0.1;
end

% Common Spectrum Analyzer Settings
Ylim = [-20 40];
NAvg = 10;
% Setup Sine Wave
sinewave = dsp.Chirp('InitialFrequency',Fs/10,...
    'TargetFrequency',Fs/2.2,'SamplesPerFrame',L,'SampleRate',Fs,...
    'TargetTime',0.01);

% Create scopes
hannSA = dsp.SpectrumAnalyzer('SampleRate',Fs, ...
    'PlotAsTwoSidedSpectrum',false, ...
    'FrequencyResolutionMethod','WindowLength', ...
    'WindowLength',L, ...
    'Window','Hann', ...
    'SpectralAverages',NAvg, ...
    'Title','Hann Windowed Spectrum',...
    'FFTLengthSource','Property',...
    'FFTLength',L,...
    'YLimits',Ylim);
filterBankSA = dsp.SpectrumAnalyzer('SampleRate',Fs, ...
    'Method','Filter bank', ...
    'PlotAsTwoSidedSpectrum',false, ...
    'FrequencyResolutionMethod','NumFrequencyBands', ...
    'FFTLengthSource','Property', ...
    'FFTLength',L, ...
    'SpectralAverages',NAvg, ...
    'Title','Filter Bank Spectrum',...
    'YLimits',Ylim);

tic
while toc < 60
    % Run for 60 seconds
    x = sinewave() + sqrt(v)*randn(L,1);    
    hannSA(x);
    filterBankSA(x);
end
    
   