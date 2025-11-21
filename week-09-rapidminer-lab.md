# Lab 09 — Forecasting Houston Weather with RapidMiner / Altair AI Studio  

> Tip: In RapidMiner you can always edit operators/parameters in **Design** view.  
> If you want to change anything later, go back to Design and adjust the boxes.

---

## 1. Aim of the lab (what we are trying to do)

You have Houston weather data recorded **over time** (hourly readings).  
Your goal is to build a system that can **predict future temperature**.

To do that correctly, we must:

1. **Clean the data** → remove/fill missing gaps.  
2. **Understand repeating patterns (cycles)** → using FFT.  
3. **Train a forecasting model (ARIMA)** → predict next 7 days/steps.  
4. **Check accuracy** → using error numbers.

Why this order matters:
- If data has blanks, forecasting math breaks.
- If you don’t understand cycles, you won’t know what is normal vs unusual.
- If you don’t test accuracy, you can’t trust predictions.

---

## 2. Key definitions (simple but correct)

### 2.1 Time series
A **time series** is data collected in time order.  
Example: temperature every hour for years.

Why it matters:
- The **order** is important.
- Past values affect future values.

---

### 2.2 Missing values
A **missing value** is a blank/“?” cell in a column.

Why it matters:
- FFT and ARIMA do heavy math.
- Missing numbers create wrong spikes or crash the model.

---

### 2.3 Replace Missing Values (Series)
This operator fills missing values in a time series.

We use **average** replacement.

Why average?
- Weather changes smoothly.
- Average gives a realistic guess without creating fake jumps.

Example:
Humidity around a gap:  
58, 60, **missing**, 62, 61 → average ≈ 60–61 → fill gap.

---

### 2.4 Fast Fourier Transform (FFT)
FFT converts data from:

- **time view** (how values change over days/years)  
to  
- **frequency view** (how often patterns repeat)

So FFT helps find cycles like:
- daily cycles (24 hours)
- yearly seasons
- unusual spikes

Big spikes in FFT = strong repeating pattern.

---

### 2.5 Logarithm after FFT
After FFT, amplitude values are huge, so graphs look messy.  
**Log10** shrinks big values to readable size.

Rule:
- apply log to **Amplitude columns**
- **do not apply log to Frequency**

---

### 2.6 ARIMA
ARIMA predicts future values using past values.

Parameters:
- **p**: how many past values to look back at  
- **d**: how much differencing to stabilize the series  
- **q**: how many past errors to use  

You used **ARIMA(2,0,1)**:
- look back 2 temperatures
- no extra differencing needed
- use 1 past error to adjust prediction

---

### 2.7 Forecast Validation
Forecast Validation tests forecasting properly by repeatedly:
1. training on a window of past data
2. forecasting a horizon ahead
3. sliding forward and repeating

Why:
- avoids “lucky” testing
- gives honest accuracy

---

## 3. Setup

### 3.1 Install required extensions
1. Open RapidMiner / Altair AI Studio.
2. **Extensions → Marketplace**
3. Install:
   - **Series Extension**
   - **Forecast Extension**
4. Restart if asked.

Why:
These extensions add FFT, ARIMA, and time‑series missing‑value tools.

---

# Part A — Clean the Houston data

## A1. Open preprocessing process
1. In **Repositories** (left panel), open:
   **Time Series → Data Transformation**
2. Double‑click **Houston Data Preprocessing Process**.
3. You should be in **Design** view.

Why:
This process loads the Houston weather dataset so we can clean it first.

---

## A2. Run and inspect missing values
1. Click **Run (▶)**.
2. Go to **Results → Data / ExampleSet**.
3. Find columns:
   - `Humidity`
   - `Temperature/Fahrenheit`
   - `Pressure`
4. Click **Humidity header** to sort.

Why:
Manual wants you to identify missing values before fixing them.  
Sorting makes gaps easy to spot.

---

## A3. Plot 3 columns together
1. Results → **Visualizations**.
2. Plot type: **Line**  
3. X‑Axis column: `datetime`
4. Value columns: choose 3, e.g.
   - Humidity
   - Wind Speed
   - Temperature/Fahrenheit

Why:
Missing gaps or strange jumps are easier to *see* on a graph.

---

## A4. Replace missing values in all numeric columns
**Important:** FFT and ARIMA require **no missing numeric values**.

### Steps
1. Go back to **Design**.
2. Search operator: **Replace Missing Values (Series)**.
3. Drag it after the Houston data operator.
4. Connect:
   - Data **out → Replace Missing Values in**
   - Replace Missing Values **out → next operator / res**

### Run 1 — Temperature
Parameters:
- attribute filter type: `single`
- attribute: `Temperature/Fahrenheit`
- replace type numerical: `average`
- overwrite attributes 

Run.

### Run 2 — Humidity
Change attribute to `Humidity` → Run.

### Run 3 — Pressure
Change attribute to `Pressure` → Run.

Why all 3:
You already saw errors when Pressure still had gaps.  
Fixing all three ensures clean input for FFT.

---

# Part B — Find cycles with FFT

## B1. Add FFT operator
1. Design view search: **Fast Fourier Transformation**.
2. Drag it after Replace Missing Values.
3. Connect:
   Replace Missing Values **out → FFT in**

### FFT parameters
- attribute filter type: `value_type`
- value type: `numeric`
- calculate frequency: `24`

Why 24:
Hourly data → 24 hours = 1 daily cycle.  
FFT uses this to detect daily repeating patterns correctly.

---

# Part C — Make FFT readable using Log10

## C1. Add Logarithm operator
1. Search: **Logarithm**
2. Drag after FFT.
3. Connect:
   FFT **fft out → Logarithm in**  
   *(not the “ori” output)*

Why:
`ori` is raw data including datetime, which can’t be logged.  
`fft` contains the numeric amplitude values we *do* want to log.

---

## C2. Select amplitude columns only
Parameters:
- attribute filter type: `subset`
- select only columns ending `_Amplitude`
- logarithm type: `log10`
- include special attributes  off

Why:
Amplitude values are huge → log makes them readable.  
Frequency is tiny → logging it would distort it.

---

# Part D — Forecast Temperature using ARIMA

## D1. Open ARIMA process
1. Repositories → **ARIMA models**
2. Double‑click **Houston ARIMA**.

Why:
This process is built for forecasting temperature.

---

## D2. Add Forecast Validation
1. Search operator: **Forecast Validation**
2. Drag into process.
3. Connect data output → Forecast Validation input.

### Parameters
- time series attribute: `Temperature/Fahrenheit`
- window size: `100`
- step size: `1`
- horizon size: `7`

Why:
- **100‑point window** = model learns from last 100 values.  
- **horizon 7** = predict next 7 steps/days.  
- **step 1** = test repeatedly with sliding windows for fair accuracy.

---

## D3. Inside Forecast Validation
1. Double‑click Forecast Validation.

### Training side
1. Add **ARIMA** operator.
2. Set:
   - time series attribute: `Temperature/Fahrenheit`
   - indices attribute: `datetime`
   - p = `2`
   - d = `0`
   - q = `1`
   - main criterion = `aic`

Why:
AIC helps choose a model that fits well without over‑complicating.

### Testing side
1. Add **Performance (Regression)**.
2. Connect forecast outputs to it.

Why:
Temperature is numeric, so we use regression error measures.

3. Go back to main process, ensure outputs go to `res`.
4. Run.

---

# Part E — Understanding your results

## E1. Forecast plot
You will see:
- **Green line** = real temperature  
- **Blue line** = forecast temperature  
- **Orange band** = forecast position (1–7)

Interpretation:
- Blue close to green → good forecasting.  
- Blue far from green → weak forecasting.

---

## E2. ArimaModel tab
Shows the learned model:
- ARIMA(p,d,q) values  
- AR and MA coefficients  

Your model:  
**ARIMA(2,0,1)** → uses last 2 temps and 1 error term.

---

## E3. Performance tab
You saw:

- **absolute error ~ 6.9**  
  → forecast is off by about **7°F on average**.  

- **relative error ~ 11%**  
  → forecast is about **11% wrong on average**.  

Why we measure these:  
Graphs can “look good,” but these numbers prove real accuracy.

---

# Part F — Common errors and fixes

### Error: *“Attribute contains non‑finite values”*
Cause: some numeric column still has missing values (often Pressure).  
Fix: Replace Missing Values for **Temperature, Humidity, Pressure** before FFT.

---

### Error: *“Attribute filter does not match any attributes”*
Cause: column name you selected (like “Frequency”) doesn’t exist exactly.  
Fix: Run once → check exact column names → select amplitudes only.

---

### Error: *“Input connection missing”*
Cause: operator has no wire into its input.  
Fix: connect previous operator’s output → this operator’s input.

---

## summary
We cleaned missing Houston weather readings, used FFT + log10 to reveal repeating cycles, then trained and tested an ARIMA model to forecast the next 7 temperature steps and measured its accuracy.
