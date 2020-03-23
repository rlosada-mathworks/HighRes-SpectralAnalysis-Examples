# HighRes-SpectralAnalysis-Examples
Examples to accompany tutorial video on using a channelizer filter bank for spectral analysis: https://www.youtube.com/watch?v=0-q9gwYZZ1o&amp;t=47s

## Introduction
This is a collection of MATLAB functions and Simulink models used as examples when comparing the filter bank approach with modified periodograms in the tutorial video linked above.

## Contents and requirements
All functions and models require R2017b or newer versions of MATLAB(R), Simulink(R) and DSP System Toolbox(TM).

In addition, the following files require the Communications Toolbox(TM):
functions/QAMTxRx.m
models/QAM_MatchedFilter.slx

The complete list of examples is:
functions/
QAMTxRx.m                                   - Simple 16 QAM Tx/Rx simulation
SingleSineShortSegment.m                    - Spectral analysis of short sinusoid 
TwoSineWavesCloseTogether.m                 - Distinguish between two sine waves
SineWavePlusNoiseWithAndWithoutAveraging.m  - Averaging vs No-Averaging analysis
TransientComparison.m                       - Transient response of filter bank 

models/
QAM_MatchedFilter.slx                       - Simple 16 QAM Tx/Rx simulation
SingleSine_ShortSegment.slx                 - Spectral analysis of short sinusoid
SinePlusNoiseTransient.slx                  - Transient response of filter bank
TwoSinusoidsCloseTogether.slx               - Distinguish between two sine waves
SinePlusNoiseWithAndWithoutAveraging.slx    - Averaging vs No-Averaging analysis

## Usage
All functions and models can be run with no extra configuration or parameters out of the box.

In particular, all functions provided include default input values to demonstrate a particular concept. The input values can be changed to experiment the effect that such values have on the spectral estimates. 

