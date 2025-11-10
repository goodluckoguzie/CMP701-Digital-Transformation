# Step-by-Step Forecasting Lab in RapidMiner Using Houston Dataset

## Lab 09: Forecasting Data Using RapidMiner – Step-by-Step Guide

In this tutorial, we will walk through Practical Lab 09: Forecasting Data using RapidMiner. We’ll use RapidMiner Studio (with the Series Extension and Forecast Extension installed) to analyze a time series from Houston and build a forecast model. The lab involves:

- Loading the Houston dataset (which contains time-series data like temperature, humidity, etc.).
- Handling missing values in the dataset.
- Performing a Fast Fourier Transform (FFT) to find periodic patterns.
- Building an ARIMA model to forecast future values, and validating its performance.

We explain each step in very simple terms, suitable for a beginner (around age 15). Follow along to reproduce the results in RapidMiner and understand the process for your coursework.

## Getting the Houston Dataset

First, we need the Houston time-series dataset for this lab. This dataset likely contains weather measurements (e.g. Temperature, Humidity, Pressure, Wind Speed) recorded over time in Houston. Where to find the dataset: Check if your instructor or course platform provided the “Houston” data file or a pre-made RapidMiner process file. In the lab manual, it says “Open Houston Data Preprocessing Process”, which suggests they gave you a RapidMiner process with the data. If so, open that file in RapidMiner (double-click it, or use File > Import Process). The dataset might already be loaded in that process.

If you only have a raw data file (like Houston_weather.csv), you can import it manually:

- Save the CSV file to your computer.
- In RapidMiner, click “Add Data” (or go to File > Import Data). Choose the CSV file and follow the wizard to import it into RapidMiner’s Repositories.

Once imported, you’ll see the dataset in your repository (for example, under “Local Repository > data”). You can drag it onto the Process canvas.

Understanding the data: The Houston dataset is time-series data, meaning each row is a time point (e.g. an hour or a day) with columns like Temperature, Humidity, etc., and possibly a Date/Time stamp. After loading the data, run it through an Output (connect the dataset to the output and click the Run button) to preview it in RapidMiner’s Results. You should see a table of the values.

Inspect for missing values: Look at the columns (especially Temperature, Humidity, Pressure). The lab hints that some entries are missing (“Do you find any missing values?”). Missing values in RapidMiner appear as ?. An easy way to spot them is to sort a column: for example, right-click the Humidity column header and choose Sort – missing entries (the ?s) may float to top or bottom. You can also switch to Charts view and plot the series; missing points will show as gaps in the line.

## Replacing Missing Values in the Time Series

Real-world data often has gaps or missing readings. We must fill these in before analysis, using a reasonable method so as not to distort the data. RapidMiner’s Replace Missing Values (Series) operator is designed for time series, allowing context-aware filling (like using neighboring points’ values) [docs](https://docs.rapidminer.com/latest/studio/operators/modeling/time_series/transformation/replace_missing_values.html).

Steps to Handle Missing Data:

- Add the “Replace Missing Values (Series)” Operator: In Design view, find the Operators panel (usually on the left). Search for “Replace Missing Values (Series)” – it’s under Modeling > Time Series > Transformation. Drag this operator into the Process canvas. Now, connect your data source to it: Connect the output of the dataset (the round port on the dataset icon) to the input of the Replace Missing Values (Series) operator. Also connect the operator’s output to the Process result (so we can see the result after filling).
- Configure the operator to fill Temperature: Click on the Replace Missing Values (Series) operator to see its parameters (in the Parameters panel on the right). We will fill missing Temperature values first. Set the parameters as follows:
  - attribute_filter_type: single – we will target one column at a time.
  - attribute: select “Temperature/Fahrenheit” (or the name of the temperature column in your data) from the dropdown. This tells the operator which series to fill.
  - replace_type_numerical: choose “average”. This means it will replace missing numeric values with the average of their neighboring values in the time series. (In other words, if one day’s temperature is missing, it may use the average of the previous and next day’s temperature. This is a simple way to interpolate a reasonable value.)
  - Leave other settings at default. (By default, it will ensure no missing remain at the start/end by carrying nearest values forward/backward if needed [docs](https://docs.rapidminer.com/latest/studio/operators/modeling/time_series/transformation/replace_missing_values.html).)
- Run the process to fill Temperature: Click Run. RapidMiner will process the data. In the Results view, examine the Temperature column. The ? marks should be gone for Temperature. The missing entries have been replaced by average values. Figure: After replacing missing values, the temperature series has no gaps. The orange line is the filled temperature curve, and the red X marks indicate where missing data points were filled with interpolated values.

Tip: You can verify the filling by looking at the Temperature values or plotting the Temperature over time. There should no longer be breaks in the line where data was missing.

Fill missing Humidity and Pressure: The Temperature is fixed, but we likely still have missing values in Humidity and Pressure (per the lab: “Remove the missing values for Humidity and Pressure columns.”). We will repeat the process for those:

- You can reuse another Replace Missing Values (Series) operator for each, or use one operator for all numeric columns. For simplicity, do one at a time:
- Add another Replace Missing Values (Series) operator (or reuse the same one by changing its settings and re-running for each column). Connect it after the first operator (or reconnect the data to this new one).
- Set attribute_filter_type = single, attribute = Humidity, replace_type_numerical = average. Run to fill Humidity gaps.
- Then do the same for Pressure (set attribute to Pressure, run again).

After these steps, all missing values should be gone. Verify in the results that Humidity and Pressure columns have no ?.

Why “average”? – Using the average of neighboring points (effectively a linear interpolation) is a reasonable approach for smooth data like weather. It prevents sudden jumps. Alternatively, other strategies (like “previous value” or “zero”) could be used, but average/linear is a common choice for time series continuity.

Now our dataset is complete with no missing values. We can proceed to analyze periodic patterns.

## Analyzing Periodicity with Fast Fourier Transformation (FFT)

Time series often have repeating cycles (for example, daily or weekly patterns in weather or sales data). Fast Fourier Transform (FFT) is a tool that converts a time series from the time domain into the frequency domain. In simple terms, it shows what frequencies (or cycles) are present in the data. This helps us identify regular patterns:

For example, an FFT can reveal if there’s a strong 24-hour cycle or a 7-day cycle in the data by showing a spike at that frequency.

Think of it like listening to a song and picking out the base beat versus a high-pitch melody – FFT separates the “beats” of your data. This is very useful in forecasting to know dominant periods.

Steps to Perform FFT in RapidMiner:

- Add the “Fast Fourier Transformation” operator: In the Operators panel, search for Fast Fourier Transformation (Time Series) (under Modeling > Time Series > Transformation). Drag it after the missing-value operators (so it takes the cleaned data as input). Connect the output of the last Replace Missing Values operator to the FFT operator’s input, and FFT’s output to the result. (Remove any old connections to result to avoid confusion.)
- Configure FFT parameters: Click the FFT operator and set:
  - attribute_filter_type: value_type – this means “apply FFT to all attributes of a certain type.” We will use it to select all numeric time series columns at once.
  - value_type: numeric. This selects all numeric columns (Temperature, Humidity, Pressure, etc.) as time series to transform. Only numeric data can be FFT’d.
  - calculate_frequency: 24. This is an important setting. Since our original data might be hourly, the number 24 here indicates 24 observations per cycle, i.e. 24 hours in a day. Essentially we are telling RapidMiner that 24 data points = 1 day. This helps FFT identify daily frequencies. In practice: Setting this to 24 means the FFT output will interpret frequencies in terms of “per day” cycles (each day will contribute one data point in frequency domain).
  - If your data is hourly, use 24. (If it were daily data, you might use 7 to focus on weekly cycles, but here the lab expects hourly data with daily cycle.)
  - Leave add_phase_spectrum as default (we only need amplitude spectrum for this lab).
- Run the FFT: Execute the process. The FFT operator will output a new ExampleSet containing frequency-domain data. In Results, you’ll see columns like “Frequency” and “Amplitude Spectrum (Temperature/Fahrenheit)”, “Amplitude Spectrum (Humidity)”, etc. This data is the strength of cycles at various frequencies. However, the numbers might be very large or very small, making it hard to see patterns directly.
- Convert to Log scale for analysis: To make the spectrum easier to visualize, we apply a logarithm. This compresses the scale of values (so big spikes and small spikes fit in one view). Add a Logarithm operator (you can find it under Modeling > Time Series > Transformation, or just search “Logarithm”). Connect it after the FFT operator (FFT’s output to Logarithm’s input, and Logarithm’s output to result). Configure it:
  - attribute_filter_type: value_type (to select numeric columns) [docs](https://docs.rapidminer.com/latest/studio/operators/modeling/time_series/transformation/logarithm.html).
  - value_type: numeric (so it will take all numeric results from FFT, i.e. the amplitude columns).
  - base: you can choose log10 (base-10) or natural ln. Either is fine; base-10 is common for clarity [docs](https://docs.rapidminer.com/latest/studio/operators/modeling/time_series/transformation/logarithm.html).
  - Important: Exclude the “Frequency” column from log transform because frequency values (the x-axis) are not to be logged. (In RapidMiner, the Frequency might be a regular attribute too. If you keep attribute_filter_type = numeric, it might try to log-transform the Frequency as well, which isn’t desired because frequency values near 0 would become negative infinity.) One way to exclude it is to set attribute_filter_type to subset and manually select all amplitude spectrum columns. Alternatively, use regular_expression filter to include “Amplitude” and exclude “Frequency”. If unsure, an easy method is: first remove the Frequency column (using Select Attributes operator) or ignore it, then apply Log to the rest. The lab specifically notes “we can't run log on the Frequency column as it’s extremely low-valued”, meaning we should avoid applying log to the frequency field.
- After setting up, run the process again. Now the FFT amplitudes will be on a log scale, which is much easier to visualize.
- Visualize the FFT result: In the Results, select the FFT output (it might appear under “fft transformed example set”). Click on the Visualizations tab. Choose a Line Chart. Set the X-axis to Frequency and Y-axis to the amplitude spectrum of interest (for example, “Amplitude Spectrum (Temperature/Fahrenheit)” or any other series’ spectrum). You should see a line that possibly spikes up at certain points. These spikes indicate strong periodic components in the data. Interpretation: Look for the highest spike. If you set calculate_frequency = 24 for hourly data, a spike at frequency = 1 on the chart would correspond to a 24-hour (daily) cycle (1 cycle per day). A spike at frequency = 7 (if it existed) would correspond to a 24/7 = ~3.4 hour cycle – probably not relevant. More realistically, you might see a spike at frequency ≈ 0.14 (if the X-axis is continuous), which corresponds to 7 days (1 cycle per 7 days ≈ 0.142 cycles/day). In other words, a weekly pattern. For simplicity, identify the major cycle:
  - In many weather datasets, you’ll notice a daily cycle (if data is hourly) or perhaps a weekly pattern in some variables.
- Figure: Logarithmic amplitude spectrum of the Houston time series after FFT. The tallest peak (marked by the red dashed line) corresponds to a 7-day cycle in the data. In an hourly dataset, a daily cycle (24-hour) would show up as a prominent frequency as well. Higher frequency noise appears as smaller fluctuations.

Note: The FFT has helped us discover periodic trends. For example, if we found a spike at the 24-hour frequency, that means the data has a strong daily rhythm. A spike at 7-day indicates a weekly cycle (perhaps weekdays vs weekends differ). This insight can guide our forecasting model (e.g. an ARIMA model might need to account for a weekly seasonality).

Now that we’ve explored the data’s periodic patterns, the next step is to build a forecasting model.

## Building and Validating an ARIMA Forecast Model

Finally, we will create a forecast model to predict future values of our time series. We’ll use ARIMA, a popular model for time-series forecasting. ARIMA stands for AutoRegressive Integrated Moving Average:

- AutoRegressive (AR): The model uses past values of the series to predict future values (think of it as “memory” of past points – e.g., yesterday’s value influences today’s).
- Integrated (I): This refers to differencing the data to remove trends and make it stationary (stable mean). A first difference (d=1) means model uses changes rather than raw values, which helps if the data has a trend.
- Moving Average (MA): The model also uses past errors (random shocks) to improve predictions (like smoothing out noise).

In ARIMA(p, d, q):

- p = number of AR (lag) terms (how many past points to look at).
- d = number of differences (how many times to subtract previous value to remove trend).
- q = number of MA terms (how many past forecast errors to include).

Don’t be intimidated – we will set these parameters and RapidMiner will train the model for us. We will also use Forecast Validation, a special validation operator for time series, to evaluate our model’s performance on a forecast horizon (future period). Forecast Validation is like Cross-Validation but for time-dependent data: it will train the model on an initial window of data, test it on the next future points, and optionally slide the window and repeat, to simulate forecasting multiple future points [docs](https://docs.rapidminer.com/latest/studio/operators/modeling/time_series/validation/forecast_validation.html). This will give us an idea of how well the model predicts, and we’ll get the final model to use.

Steps to Build the ARIMA Model:

- Set up Forecast Validation: In the Operators panel, search for Forecast Validation (under Modeling > Time Series > Validation). Drag it into the process canvas (after the FFT and Log operators if they were connected; you can actually remove or disconnect the FFT part now, as it was for analysis – the forecasting will typically use the original time series). It might be easier to start a new subprocess for forecasting: you can take the original cleaned data (after missing value replacement) and connect it into Forecast Validation. The lab manual suggests opening a separate process “Houston ARIMA process”, so if such a process file was provided, use that. Otherwise, continue in the same process:
  - Connect the cleaned data output (from the last Replace Missing Values operator, or from the Log if you want to forecast a transformed series) into the Forecast Validation operator’s input.
  - The Forecast Validation operator has multiple ports: one for the ExampleSet (input data), and outputs for the model, performance, etc., plus special inner ports. Don’t worry, we’ll set it up step by step.
- Configure Forecast Validation parameters: Click on Forecast Validation to set the main parameters in its parameter panel [docs](https://docs.rapidminer.com/latest/studio/operators/modeling/time_series/validation/forecast_validation.html):
  - time_series_attribute: Choose the column you want to forecast (the target variable). For example, if we want to predict Temperature, select Temperature/Fahrenheit (or whichever attribute is of interest) [docs](https://docs.rapidminer.com/latest/studio/operators/modeling/time_series/validation/forecast_validation.html). This is the the series the model will learn and forecast.
  - has_indices: If your data has a time index (like a Date column), set this to true [docs](https://docs.rapidminer.com/latest/studio/operators/modeling/time_series/validation/forecast_validation.html), then specify indices_attribute as the Date/Time column. This helps RapidMiner know the order of data and the actual time spacing. If you don’t have a date column but data is in correct chronological order, you can leave this false (it will then use the row order as time order).
  - window_size: Set how many past observations the model should train on for each forecast. For example, if data is daily and you set window_size = 30, the model will use 30 days of history to predict the next period [docs](https://docs.rapidminer.com/latest/studio/operators/modeling/time_series/validation/forecast_validation.html). A larger window means more data to train but maybe slower or risk overfitting; a smaller window means using only recent data. In absence of specific instruction, a few weeks or months of data is a good start. (The lab manual did not explicitly give a number, but you can choose one. Ensure it’s smaller than the total length. For example, if you have ~365 days of data, window_size 300 could work, leaving some for testing.)
  - horizon_size: This is how many future time points to predict in one go (the forecast horizon) [docs](https://docs.rapidminer.com/latest/studio/operators/modeling/time_series/validation/forecast_validation.html). The lab says “7 days forecast”, so set horizon_size = 7. This means each evaluation will predict 7 steps ahead (e.g. a week into the future).
  - step_size: This is how far to move the window each time for validation. If you want to simulate forecasting every day, you could use step_size = 1 (windows slide one day forward each fold). If you want non-overlapping train periods, you could set no_overlapping_windows = true, and RapidMiner will automatically set step_size = window_size (so train on one chunk, then jump past it) [docs](https://docs.rapidminer.com/latest/studio/operators/modeling/time_series/validation/forecast_validation.html). For more thorough evaluation, using step_size = 1 (with overlapping windows) is fine. Leave no_overlapping false for now and just use step_size = 1.
  - Leave other parameters default (they involve advanced settings).
- Open the Forecast Validation subprocess: The Forecast Validation operator contains two inner subprocesses – one for Training (to train the model on the training window) and one for Testing (to apply the model and measure performance on the horizon). To set these up:
  - Open the operator by double-clicking it (or right-click and choose “Open Process”). You will see two empty subprocess panels: one labeled Training, one Testing.
  - In the Training part (left side), we need to train an ARIMA model. Find and drag ARIMA (Time Series) operator (under Modeling > Time Series > Forecasting) into the Training panel. Connect the input (training set) port to ARIMA’s input. Connect ARIMA’s output (the model it produces) to the model output port of the Training panel. (There may be a port icon that says “model” – connect ARIMA’s model out to that.)
  - Click the ARIMA operator to set its parameters:
    - time_series_attribute: Again select the target series (Temperature, etc.) [docs](https://docs.rapidminer.com/latest/studio/operators/modeling/time_series/forecasting/arima_trainer.html) – it should match what you set in Forecast Validation.
    - has_indices: set true if you have a date index in the training subset, and select the index attribute (just like before) [docs](https://docs.rapidminer.com/latest/studio/operators/modeling/time_series/forecasting/arima_trainer.html).
    - p, d, q: These are the ARIMA orders we discussed. The lab manual expects you to choose some values. If not specified, you can start with a simple model. For example:
      - If your data is stationary (no strong trend), you can try d = 0 (no differencing). If there is an upward or downward trend, use d = 1 to difference once (remove one order of trend).
      - Choose p (AR lags) based on any autocorrelation you suspect. For a daily pattern, you might use p = 7 (to allow a week-back value to influence prediction). If daily data has weekly seasonality, p=7 is a reasonable guess. Otherwise, p = 1 or 2 is a simple choice.
      - Choose q (MA terms) maybe 1 or 2 to allow some error correction.
      - For example: set p = 7, d = 1, q = 0 as an initial model. This means the model looks at the past 7 days and one difference (so it models week-over-week changes) – a simple way to capture weekly pattern. (Another example could be p=2,d=1,q=2 for a more flexible model.)
      - The manual doesn’t give exact numbers, so these are reasonable assumptions. ARIMA will fit coefficients for these terms automatically.
    - estimate_constant: You can leave this true (the model will include a constant term by default, unless differencing makes mean ~0).
    - Leave other parameters at default.
    - (For advanced users: ARIMA training will output AIC/BIC in a Performance Vector port if you connect it, but we won’t delve into that here.)
  - Now the Training subprocess is set: it takes a training window and produces an ARIMA model.
- Set up the Testing subprocess: Click the Testing tab (right side of Forecast Validation). Here we use the model on the test window and evaluate performance:
  - There will be an input port (this receives the test window data) and a model input (which gets the model from training) already on the panel. RapidMiner’s Forecast Validation automatically uses the model to predict the test window, so we do not need to add an Apply Model or Apply Forecast operator – it’s implicit. The output test data will already contain the forecasted values for the horizon [docs](https://docs.rapidminer.com/latest/studio/operators/modeling/time_series/validation/forecast_validation.html).
  - What we do need is a Performance evaluation. Search and drag Performance (Regression) into this Testing panel. Connect its input to the Test ExampleSet (the round port). Connect the label and prediction correctly if needed:
    - RapidMiner should automatically assign the actual values of the target as “label” and the forecasted values as “prediction” roles (Forecast Validation does this under the hood: the output test set has a column with true values and one with the forecast, with roles set accordingly [docs](https://docs.rapidminer.com/latest/studio/operators/modeling/time_series/validation/forecast_validation.html)). The Performance operator will detect those. If not, you may manually set the role of the actual value column to “label” and predicted to “prediction” using a Set Role operator before Performance.
    - Click Performance (Regression) to configure metrics. By default, it might compute RMSE, MAE, etc. You can choose to enable specific metrics in parameters (e.g., set error measure to absolute or square if needed, or check a box for Relative Error to get percentage error). The lab likely expects some basic error measurement. A good one for forecasting is RMSE (Root Mean Squared Error) or MAE (Mean Absolute Error), and maybe MAPE (Mean Absolute Percentage Error) if you enable relative error.
  - Connect the output of Performance to the performance output port of the Testing panel (so that the average performance over all folds will be output by Forecast Validation).
- Close the subprocess: Click the Go to Parent button to exit back to the main process. Now connect the output ports of Forecast Validation to results:
  - Connect the model output (this will be the ARIMA model from the last training fold) to result if you want to see the model.
  - Connect the performance output to result to see the error metrics.
  - Connect the test result set output to result if available (this is the concatenated predictions vs actuals for all test windows) [docs](https://docs.rapidminer.com/latest/studio/operators/modeling/time_series/validation/forecast_validation.html). It’s often useful for plotting predictions.
- Run the Forecast Validation: Execute the process. It will train the ARIMA on the first window, predict the next 7 days, then possibly slide and repeat (depending on step size and data length). In the end, you get:
  - An ARIMA model (you can click on it in results to see details like the coefficients and orders it used).
  - A Performance Vector with error metrics (this might be the average error across folds if multiple folds were done). Check the values – e.g., it might show something like RMSE = 2.5 (in the units of your data) etc., indicating how close the forecasts were on average.
  - A Test Result ExampleSet, which typically contains the actual and forecasted values for each predicted point. It usually has a column with the actual series (label), one with the forecast (prediction), and an index or “forecast_position” column.
- Examine the output: The lab specifically mentions a column “forecast position” – this is an indicator of how far ahead each prediction is (e.g., 1 through 7 for a 7-day horizon). If you had overlapping windows, you will have multiple predictions for some positions. For instance, forecast_position = 1 are all 1-day-ahead predictions (made multiple times), position = 7 are 7-days-ahead predictions. This can be used to analyze how accuracy degrades for longer horizons. Figure: Actual vs Predicted values for a 7-day forecast using the ARIMA model. The orange dashed line shows the ARIMA model’s forecast for the next 7 days, compared to the actual observed values (blue line). This plot is derived from RapidMiner’s Forecast Validation results and demonstrates the model’s performance in predicting one week ahead.
- Visualize the forecast: You can plot the results to visually assess the forecast:
  - In the Results, select the test result set (the merged output of forecast validation). Go to Visualizations. Plot a line chart: use the time index (or Example index if no time attribute) on X-axis, and both the actual and forecast values on Y-axis. You should see two lines – one for actual data and one for forecasted. The forecasted line will overlap the actual for the periods that were predicted.
  - To distinguish different horizons, as suggested in the lab, you can use the “forecast_position” as a color category. For example, set Color grouping by forecast_position, and you can filter which positions to display. For example, the 1-step ahead predictions track actual closely, while the 7-step ahead might deviate more.
  - In our example figure above, you can see the forecast (orange) follows the general trend of the actual (blue), but not perfectly – this is expected. The error metrics quantify this difference.
- Interpretation of ARIMA output: The ARIMA model you trained can now be used to forecast future data (beyond what was tested). The last model (output by Forecast Validation) is trained on the latest window of data. You could apply it to the entire series to forecast the next 7 days beyond your dataset. In RapidMiner, you would use an Apply Forecast operator with this model on the full data to get actual future values. The lab does not explicitly cover that, but it focuses on understanding the process and validation.

## Key Takeaways

- We handled missing data so that the model isn’t confused by gaps.
- FFT revealed a periodic pattern in the data (in our case, a weekly cycle). Understanding this helps in choosing model parameters.
- We built an ARIMA model, which is a standard tool for forecasting. We learned what p, d, q mean in simple terms.
- We used Forecast Validation to simulate making forecasts and to evaluate the model’s accuracy on unseen data (future points). This is crucial for checking if the model will generalize well.
- Finally, we visualized the forecast versus actual to see how well the model performs and where it might deviate.

With this step-by-step guide, you should be able to reproduce Lab 09’s results. You can include the key graphs (like the FFT spectrum and the forecast plot) in your coursework to illustrate the patterns found and the forecast performance. Most importantly, you now have a clearer understanding of how to use RapidMiner for time series forecasting tasks – from data preprocessing to model evaluation. Good luck with your analysis!