# Honors-Thesis-Matlab-Scripts-Functions
The scripts and functions used to produce the models and figures for my honors thesis.

The ".mlx" files are live functions that are used in the ".m" scripts.
- RTFreqResponse: produces the frequency response of the room temperature model
- HT200CFreqResponse: produces the frequency response of the 200C probe tip temperature model
- HT400CFreqResponse: produces the frequency response of the 400C probe tip temperature model
- HT600CFreqResponse: produces the frequency response of the 600C probe tip temperature model
- HT800CFreqResponse: produces the frequency response of the 800C probe tip temperature model

The ".m" scripts used the ".mlx" live functions to do something else
- RoomTempCurveFit: does a nonlinear least squares curve fit of the room temperature model onto Vera's experimental calibration data
- RTModelVSVeraCalibration: displays the plot comparing the unfitted and fitted room temperature models
- HighTempModels: displays the plot of all models (room temp, 200C, 400C, 600C, 800C) unfitted
