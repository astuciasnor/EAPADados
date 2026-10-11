# Stress, growth, and osmoregulatory data for the Atlantic Whitefish at different salinities

Dataset DOI: [10.5061/dryad.bg79cnpph](https://doi.org/10.5061/dryad.bg79cnpph)

## Description of the data and file structure

### Methods of Data Collection

Data contributing to variables was collected from anaesthetized fish on specific days throughout the experimental period (1, 22, 50, 74, 116, 174, 252).

#### Percent growth per degree day (%Growth DD ^-1^)

Fork length (mm) and mass (g) were measured approximately once per month (each fish was handled on all of days 1, 22, 50, 74, 116, and either 174 or 252). To correct for potential effects of temperature variation and any differences in initial size, we calculated the percentage of growth (%growth) per degree day (DD). The number of degree days experienced by each fish were calculated using the following equation from *Honsey et al. (2023)*:

**(1)**     *DD = ∑^N^~t=1~*&#x20;*&#xA0;(T~1 -~* *T~0~&#xA0;*)*, T~1~* *> T~0~*

T~1~ is the average temperature for day 1, and T~0~ is a species-specific temperature below which thermal energy is assumed to have no effect on physiological processes (e.g. growth; Honsey et al., 2023). We used a T~0~ value of 0˚C (recommended for coregonids by Chezik et al., 2014; Honsey et al., 2023), so Equation 1 is simplified to:

**(1.1)**   *DD = ∑^N^~t=1~* *(T~1~*)

Any days missing temperature data were averaged from the temperature of that tank in the preceding and following days. Prior to day 110, water temperature was not measured, but heat settings were identical to days 110 – 187, so daily temperature in each tank prior to day 110 was assigned the average temperature from days 110-140. Fish were not individually tagged, so to calculate %growth of individuals, we reported the size of an individual fish measured on day 174 as a percentage of the average size of all fish (n = 10) in its original tank on day 1. Despite correcting for temperature in equations 1 and 1.1, day 174 was chosen as the end date for growth measurements to avoid confounding salinity with the increase in temperature over the course of days 188-199. Percent growth per degree day (%Growth DD ^-1^) was calculated using weight (g) data and the number DD experienced by that fish.

#### Relative condition factor (*wW ^-1^*)

To compare fish condition across salinities, we calculated relative condition factor (*wW ^-1^*)(Le Cren, 1951) for each individual measured on day 174 (cool group) and 252 (warm group). Relative condition factor is the ratio of the observed weight over the expected weight based on a linear regression of the control (FW, 0ppt) group. Our linear regression produced the following equation (R^2^ = 0.967) to predict weight from fork length (FL).

**(2)** log(W) = 3.5051 x log(L) - 6.1059 

Where W is the expected fish weight (g) and L is the fish fork length (mm).

#### Whole blood lactate and glucose

Blood samples were taken on day 174 (cool samples, 12 ± 2˚C) and day 252 (warm samples, 17 ± 2˚C) from 10 fish per salinity on each day (n = 60; Figure 2). Cool and warm samples were taken from different fish. Whole blood glucose and lactate levels were measured from whole blood immediately after extraction using the ContourNext EZ© glucose meter (Ascensia Diabetes Care, Canada) and the EDGE ™ lactate meter (the Edge, USA).

#### Plasma osmolarity and cortisol

Total plasma osmolarity was measured in 50 μL sample volumes using a μ·Osmette^TM^ micro-osmometer (Precision Systems Inc, USA). Where necessary, plasma samples were diluted to 50 μL with urine diluent (317.67 mOsm; Diamond Diagnostics, USA) and osmolarity calculated using a dilution factor. Cortisol was measured using an enzyme-linked immunosorbent assay (Neogen® corporation, USA) on a SpectraMax M3 spectrophotometer (Molecular Devices, USA) according to the manufacturer’s with the following changes. During extraction ethyl ether was evaporated in bulk using a vacuum desiccator outfitted with argon gas (A~2~) instead of individually using a stream of nitrogen gas (N~2~). Instead of 100 μL of plasma, we extracted cortisol using only 10 μL of plasma plus 90 μL of urine diluent (Diamond Diagnostics, USA). Consequently, to ensure that samples fell within the detection range of the assay, we reduced the dilution of the sample to extraction buffer from 100-fold to 10-fold. Due to available plasma volume, only samples from the warm group sampled on day 252 were used in analyses (and thus included in data package) for both cortisol and glucose. 

Chezik, K. A., Lester, N. P., & Venturelli, P. A. (2014). Fish growth and degree-days I: Selecting a base temperature for a within-population study. *Canadian Journal of Fisheries and Aquatic Sciences*, *71*(1), 47–55. [https://doi.org/10.1139/cjfas-2013-0295](https://doi.org/10.1139/cjfas-2013-0295)

Le Cren, D. (1951). The Length-Weight Relationship and Seasonal Cycle in Gonad Weight and Condition in the Perch (Perca fluviatilis). *The Journal of Animal Ecology*, *20*(2), 201. [https://doi.org/10.2307/1540](https://doi.org/10.2307/1540)

Honsey, A. E., Rypel, A. L., & Venturelli, P. A. (2023). Guidance for selecting base temperatures when using degree-days in fish growth analyses. *Canadian Journal of Fisheries and Aquatic Sciences*, *80*(3), 549–562. [https://doi.org/10.1139/cjfas-2022-0197](https://doi.org/10.1139/cjfas-2022-0197)

### Files and variables

**File_A.csv:** Analysis-ready condition, lactate, glucose and plasma osmolarity and cortisol data organized by fish, temperature group and salinity.

**File_B.csv:** Condition factor calculations for individual fish based on growth data.

**File_C.csv:** Calculation of %Growth per degree day (%Growth DD ^-1^) based on size data and number of degree days experienced

**File_D.csv**: Raw growth measurements for fish from days 1, 22, 50, 74, 116, 174 and 252

#### Variables:

See Data Description for the method of collection for the variables below.

**File A:**

* Source Tank: Housing tank for the fish in question between days 1 and 116.
* Tank: Housing tank for the fish in question between days 116 and 174 *or* days 116 and 252, depending on the measurement group (cool vs warm)
* Salinity: Treatment salinity (ppt)
* Fish ID: Fish identification code for fish measured on days 174 or 252
* Day: Sample day (174 or 252)
* Temp: Temperature group corresponding to sample day (174 or 252)
* Relative condition factor: Measure of body condition (*wW ^-1^*), observed condition over expected condition; see File B
* Lactate: Whole blood lactate (mmol/L)
* Glucose: Whole blood glucose (mmol/L)
* Plasma Cortisol: Blood plasma cortisol (ng/L) for the warm group
* Total Osmolarity: Plasma total osmolarity (mOsm) for the warm group

**File B:**

* Source Tank: Housing tank for the fish in question between days 1 and 116.
* Tank: Housing tank for the fish in question between days 116 and 174 *or* days 116 and 252, depending on the measurement group (cool vs warm)
* Salinity: Treatment salinity (ppt)
* Fish ID: Fish identification code for fish measured on days 174 or 252
* Day: Sample day (174 or 252)
* Temp: Temperature group corresponding to sample day (174 or 252)
* Length: Total length (TL) in millimetres (mm)
* Weight: Wet mass in grams (g)
* log length: Base 10 logarithm of length
* log weight: Base 10 logarithm of weight
* Expected Weight: Expected mass (g) based on a linear regression of the freshwater control group and the observed length of the fish of interest
* Relative condition factor: Ratio of observed mass over expected mass.

**File C:**

* Source Tank: Housing tank for the fish in question between days 1 and 116
* Tank: Housing tank for the fish in question between days 116 and 174
* Salinity: Treatment salinity (ppt)
* Fish ID: Fish identification code for fish measured
* \#DD (1-174): The number of degree days experienced by that fish
* Length1: Total length (mm) on day 1
* Weight1: Wet mass (g) on day 1
* Length174: Total length (mm) on day 174
* Weight174: Wet mass (g) on day 174
* %Growth.L: Growth in total length as a percent of the length on day 1
* *%Growth.W:* Growth in wet mass as a percent of the mass on day 1
* %GrowthDD.Length: Percent growth per degree day as calculated using length data
* %GrowthDD.Weight: Percent growth per degree day as calculated using mass data

**File D:**

* Date: Gregorian calendar date of measurement
* Temp: Temperature period based on water temperature increase between days 188 to 199, after which the water remained warm (cool, warm)
* *Day:* Measurement day of the experiment (1, 22, 50, 74, 116, 174 and 252)
* Source Tank: Housing tank for the fish in question between days 1 and 116
* Tank: Housing tank for the fish in question between days 116 and 174 or 116 and 252, depending on the sample group (cool vs warm)
* Salinity_ppt: Treatment salinity (ppt)
* Length_mm: Total length (mm)
* Weight_g: Wet mass (g)

## Code/software

All statistical analyses were conducted using R v4.3.2 in RStudio version 2023.12. with the following packages:

* "TukeyC” (Faria et al., 2023)
* “ggplot2” (Wickham, 2016)
* “lmtest” (Hothorn et al., 2022)
* “dplyr” (Wickham et al., 2025)

Faria, J. C., Jelihovschi, E. G., & Allaman, I. B. (2023). Conventional Tukey Test [Computer software]. Universidade Estaudal de Santa Cruz.

Hothorn, T., Xeileis, A., Farebrother, R. W., Cummins, C., Millo, G., Mitchell, D. (2022). lmtest: Testing Linear Regression Models. [Computer software]. 10.32614/CRAN.package.lmtest

Wickham, H., François, R., Henry, L., Müller, K., Vaughan, D. (2025). dplyr: A Grammar of Data Manipulation. R package version 1.1.4, [https://dplyr.tidyverse.org](https://dplyr.tidyverse.org).

Wickham, H.(2016). ggplot2: Elegant Graphics for Data Analysis [Computer software]. Springer-Verlag. [https://ggplot2.tidyverse.org/](https://ggplot2.tidyverse.org/)