function SineWavePlusNoiseWithAndWithoutAveraging(NAvg,L,f,Fs,v)
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
    % Number of averages
    NAvg = 20;
end
if nargin < 2
    % Segment length
    L = 1024;
end
if nargin < 3
    % sinusoid frequency
    f = 60e6;
end
if nargin < 4
    % Sample rate
    Fs = 500e6;
end
if nargin < 5
    % Noise variance
    v = 0.1;
end

% Common Spectrum Analyzer Settings
Ylim = [-20 40];

% Setup Sine Wave
sinewave = dsp.SineWave('Amplitude',3,...
    'Frequency',f,'SamplesPerFrame',L,'SampleRate',Fs);

% Create scopes
filterBankSANoAverages = dsp.SpectrumAnalyzer('SampleRate',Fs, ...
    'Method','Filter bank', ...
    'PlotAsTwoSidedSpectrum',false, ...
    'FrequencyResolutionMethod','NumFrequencyBands', ...
    'FFTLengthSource','Property', ...
    'FFTLength',L, ...
    'SpectralAverages',1, ...
    'Title','Filter Bank Spectrum - No Averaging',...
    'YLimits',Ylim);
filterBankSA = dsp.SpectrumAnalyzer('SampleRate',Fs, ...
    'Method','Filter bank', ...
    'PlotAsTwoSidedSpectrum',false, ...
    'FrequencyResolutionMethod','NumFrequencyBands', ...
    'FFTLengthSource','Property', ...
    'FFTLength',L, ...
    'SpectralAverages',NAvg, ...
    'Title','Filter Bank Spectrum - Averaging',...
    'YLimits',Ylim);

tic
while toc < 60
    % Run for 60 seconds
    x = sinewave() + sqrt(v)*randn(L,1);    
    filterBankSANoAverages(x);
    filterBankSA(x);
end
    
   