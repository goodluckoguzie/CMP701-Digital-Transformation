# Week 3: Visualise the Data

I’ll assume you already have the two blocks on the canvas (Retrieve Full Telecom Data and Select Attributes) and you’ve opened the Select attributes… window like in your screenshot.

## 0) Setup once
We first choose only the columns we actually need. This keeps charts simple and stops errors like “column not found.” In RapidMiner, a column = attribute. We’ll keep weeks, minutes, calls, region, gender, and churn status.

In Design, click Select Attributes to show its Parameters.

Set type = include (or subset). Set attribute filter type = a subset.

Click Select attributes… and move these to the Selected list:

Weeks in Contract

Day Mins, Intl Mins, Night Mins

Day Calls, Intl Calls

Gender, Region, Churn Status

Make sure also apply to special attributes (id, label …) is unchecked.

Click Apply (green tick).

Wire Retrieve.out → SelectAttributes.exa → res.

Click Run ▶ (top bar). You’ll land on Results.

## Task 1 — Sort & review (Gender and “Calls per day”)
This is a quick health-check. Sorting shows who/what is most common and helps you spot weird values. It’s like looking at the whole class list by alphabet, then by height.

Results → Data (table view).

Click Gender header to sort A→Z; click again for Z→A.

Click Day Calls header and sort as well (or your equivalent “calls per day” column).

Glance at the top/bottom rows: note anything surprising (e.g., very high Day Calls).

Write down (1–2 lines): “Most frequent Gender is ___.” “Max Day Calls ≈ ___, typical is around ___.”

## Task 2 — Line chart with multiple minutes series
A line chart shows change over time. Our “time” is Weeks in Contract. We’ll plot three lines (Day/Intl/Night Mins) to compare how each type of minutes behaves over weeks. We aggregate by week so multiple customers in the same week become one point per line.

Go to Results → Visualizations.

In the left Plot panel:

Plot type = Line.

Click Value columns → select only: Day Mins, Intl Mins, Night Mins (these become 3 lines).

Aggregate data = ON (tick).

Group by = Weeks in Contract (this is your X-axis).

Aggregation Function = Average (or Sum if your teacher prefers totals).

Sorting = Ascending (weeks from small → big).

(Optional) turn on Legend so the line names show; add a Title if you want.

If you see an error, clear and re-pick Value columns, then Run ▶ again (it means a line pointed to a column that wasn’t selected earlier).

What to look for: Do the three lines rise/fall together? Which minutes are usually higher? Any week where a line spikes?

Write down: “Over weeks, Day Mins is generally highest; Intl Mins is lowest; there’s a spike around week __.”

## Task 3 — Scatter plot (Weeks vs Minutes), colored by Gender
A scatter shows the relationship between two numbers. We’ll plot Weeks on X and Minutes on Y. Coloring by Gender shows whether one group uses more minutes than the other.

Still in Visualizations:

Plot type = Scatter.

X-axis / Group by = Weeks in Contract.

Y-axis / Value = Day Mins (then try Intl Mins and Night Mins).

Color group = Gender.

(Optional) Sorting = none; scatter doesn’t need it.

Compare patterns: do dots trend upward (more weeks → more minutes)? Are Male/Female dots clustered differently?

Write down: “Minutes (Day Mins) [do/do not] increase with Weeks. [Gender] has slightly [higher/lower] minutes overall.”

## Task 4 — Churn Status, grouped by Gender (who is more loyal?)
We’re counting rows by Churn Status and grouping by Gender to answer: which gender has more loyal (non-churn) customers? This is a categorical comparison.

Click Statistics (left of Visualizations).

Find Churn Status → open its Visualization.
If you prefer to stay in Visualizations instead: use Plot type = Bar, X-axis = Churn Status, Measure = Count.

Set Group by / Color by = Gender.

Look at the loyal / not-churned category’s bars: whichever color is taller has more loyal customers.

Write down: “[Male/Female] has more loyal customers (taller bar in the ‘loyal’ category).”

Tip: If your version supports “Normalize to %”, toggling it can compare proportions instead of raw counts.

## Task 5 — Region vs International Calls, sorted ↓
We’re comparing regions by the total amount of international calling. This identifies where the most calling activity happens — great for business insight.

Go back to Visualizations.

Plot type = Bar (or Histogram if that’s the label).

X-axis = Region.

Measure / Value = Intl Calls with Aggregation = SUM.

Sort = Descending by the measure (largest bar first).

(Optional) turn on Data labels so the bar totals show.

What to look for: Which region has the tallest bar? Is the distribution very uneven?

Write down: “Region __ has the highest total international calls. Regions ranked next: __, __.”

## Task 6 — Color by Gender, Title, and Export (submit-ready)
Coloring makes categories visible; the Title identifies your work; Export saves an image to hand in.

While viewing your chosen chart, set Color by = Gender (or leave it off for a cleaner region ranking — your PDF likely wants Gender coloring somewhere, so include it on at least one chart).

Find the Title input → type Your Full Name – B-code.

Click Export / Download / camera icon above the chart → choose PNG → save as:

Week3_LineChart_Name_Bcode.png (line)

Week3_Scatter_Name_Bcode.png (scatter)

Week3_Region_IntlCalls_Name_Bcode.png (bar)

## Extra mini-explanations (so every term feels easy)
Attribute (column): one fact about each row (e.g., Gender, Region, Day Mins).

Special (green) vs Regular (white): green columns have roles like label or id used by models; white are normal features you plot.

Aggregate: combine many rows into one value (e.g., many customers in week 12 → average minutes for week 12).

Group by: the bucket we roll data into. We group by Weeks for lines, by Region for bars, and by Gender to split bars by color.

Count vs Sum vs Average:

Count = how many rows.

Sum = total of a numeric column.

Average = typical value (sum ÷ count).

Sort descending: biggest values first, so the “winners” are easy to see.

## Quick “it broke!” fixes
Error: “column … not contained.”
Open Select attributes…, make sure that exact column is ticked, Apply, Run ▶, then re-pick Value columns in the chart.

Blank chart:
Make sure you’re in Results → Visualizations, you set a Plot type, and chose actual columns for Value and Group by/X. If you just changed attributes, click Run ▶ again.

Wrong X for the line:
Ensure Group by = Weeks in Contract and Sort = Ascending.

Region chart not ranking:
In the plot options set Sort = Descending by SUM(Intl Calls).