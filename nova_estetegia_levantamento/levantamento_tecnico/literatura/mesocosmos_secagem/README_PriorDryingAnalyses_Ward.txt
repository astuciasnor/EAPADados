<!---
This README uses Markdown syntax, though it is saved in .txt format.
To view the file with its intended text formatting, save a copy as a .md file.
Then you can open it with the browser or text viewer of your choice.
For details on Markdown syntax, see <https://daringfireball.net/projects/markdown/>.
--->

Reference Information
=====================

Provenance for this README
--------------------------

* File name: README_PriorDryingAnalyses_Ward.txt
* Authors: Krista J. Ward, Shania E. M. Burkhead, Emily A. Stybr-Burrus, Thomas M. Luhring
* Date created: 2023-06-20
* Date modified: 2023-06-25
* Title of dataset: An analysis of the effects of prior drying and vertebrate colonization on ecological functioning and vertebrate fitness
* Corresponding publication: Krista J. Ward, Shania E. M. Burkhead, Emily A. Stybr-Burrus, Thomas M. Luhring. 2023. No free refills: prior drying and vertebrate colonization alter ecological functioning and vertebrate fitness within experimental aquatic systems. Journal of Freshwater Biology. Accepted. Manuscript # FWB-P-Sep-22-0415.


Contact Information
-------------------

  * Name: Krista J. Ward
  * Affiliations: Department of Biological Sciences, Wichita State University, Wichita, KS, U.S.A.
  * ORCID ID: https://orcid.org/0000-0001-7358-3508
  * Email: kristajoy.ward@gmail.com
  * Address: e-mail preferred

* Alternative Contact: Graduate PI
  * Name: Thomas M. Luhring
  * Affiliations: Department of Biological Sciences, Wichita State University, Wichita, KS, U.S.A.
  * Email: Thomas.luhring@gmail.com
  * Address: 1845 Fairmount St. Wichita, KS 67260-0026, Campus Box 26.
- - -

Additional Dataset Metadata
===========================

Acknowledgements
----------------

* Funding sources: Financial support for this research was provided by NSF Kansas EPSCoR grant #1930736 and the Rachel Snyder Memorial Scholarship from the Grassland Heritage Foundation. This research was logistically supported by the Wichita State University Field Station. Aquatic vertebrates were collected with Kansas Department of Wildlife, Parks, and Tourism approval (#102280898) and our experiment was conducted with Institutional Animal Care and Use Committee approval (#279a).


Dates and Locations
-------------------

* Dates of data collection: Field data collected between May and August in 2021

* Geographic locations of data collection: Fieldwork conducted at the Wichita State University’s Ninnescah Biological Reserve in Wichita, KS (see publication for more details)

* Other locations pertaining to dataset contents: Lab work was completed at Wichita State University’s Department of Biological Sciences

- - -

Methodological Information
==========================

* Methods of data collection/generation: see manuscript for details

- - -

Data and File Overview
======================

Summary Metrics
---------------

* File count: 10
* Range of individual file sizes: 3 KB - 330 KB
* File formats: .xlsx and .Rmd

Table of Contents
-----------------

* Amphibian Biomass_Dryad.xlsx
* Emergence and Biomass_Dryad.xlsx
* Fish Data_Dryad.xlsx
* Frog Metamorph Data.xlsx
* Periphyton Data_Dryad.xlsx
* Revised YSI Data_Dryad.xlsx
* Amphibian Analyses_Dryad.Rmd
* Fish Analyses_Dryad.Rmd
* Periphyton Analyses_Dryad.Rmd
* Revised YSI Analyses_Dryad.Rmd

Setup
-----

* Unpacking instructions: n/a

* Relationships between files: 
*Amphibian Analyses_Dryad.Rmd analyzes the data contained within the Amphibian Biomass_Dryad.xlsx, Emergence and Biomass_Dryad.xlsx, and Frog Metamorph Data.xlsx files
       *Fish Analyses_Dryad.Rmd analyzes the data contained within the Fish Data_Dryad.xlsx file
*Periphyton Analyses_Dryad.Rmd analyzes the data contained within the Periphyton Data_Dryad.xlsx file
*Revised YSI Analyses_Dryad.Rmd analyzes the data contained within the Revised YSI Analyses_Dryad.Rmd file

* Recommended software/tools: parentage- Microsoft Excel 2010 or newer; RStudio version 4.1.1. All statistical analyses were performed in RStudio version 4.1.1 (R Core Team, 2021). All packages required for the statistical analyses within the R program are listed at the top of each R script file. All files submitted are either .xslx or .Rmd file types and both Microsoft Excel and R Studio will be required to open the data files.

- - -

Details for: Amphibian Biomass_Dryad.xlsx
---------------------------------------

* Description: A Microsoft Excel spreadsheet containing measurements of larval amphibian mass collected throughout the study. 

* Format(s): .xlsx

* Size(s): 34 KB

* Dimensions: 593 rows X 7 columns

* Variables:
	*Tank: Number used to identify the individual replicate experimental tanks
*Treatment: Denotes the combination of tophic treatment and drying treatment applied to the experimental tank. 
		*A:DR = Amphibian only; Dry-refilled
		*A:ND = Amphibian only; Non-dried
		*F:DR = Fish only; Dry-Refilled
		*F:ND = Fish only; Non-dried
		*FA:DR = Fish and Amphibian; Dry-refilled
		*FA:ND = Fish and Amphibian; Non-dried
		*C:DR = Control (no fish or amphibian); Dry-refilled
		*C:ND = Control (no fish or amphibian); Non-dried

	*Date: The date that the data were collected
*Day: The experimental day (# of days since the experiment began). Days past Day 0. Day 0 = 5/8/2021.
	*Vol_Displ: The volumetric displacement of larval amphibians measured in mL.
	*Tadpoles: Number of larval amphibians used in the sample
*Mass: Mass per individual larval amphibian measured by volumetric displacement divided by number of amphibians used in sample. Measured in grams.
 

Details for: Emergence and Biomass_Dryad.xlsx
---------------------------------------

* Description: A Microsoft Excel spreadsheet containing size and growth data on larval amphibians that survived to metamorphosis. All data within each tank were summed and averaged to provide only a single data point for each tank.

* Format(s): .xlsx

* Size(s): 18 KB

* Dimensions: 64 rows X 16 columns

* Variables:
       *Tank: Number used to identify the individual replicate experimental tanks
*Treatment: Denotes the combination of tophic treatment and drying treatment applied to the experimental tank. 
		*A:DR = Amphibian only; Dry-refilled
		*A:ND = Amphibian only; Non-dried
		*F:DR = Fish only; Dry-Refilled
		*F:ND = Fish only; Non-dried
		*FA:DR = Fish and Amphibian; Dry-refilled
		*FA:ND = Fish and Amphibian; Non-dried
		*C:DR = Control (no fish or amphibian); Dry-refilled
		*C:ND = Control (no fish or amphibian); Non-dried
       *Emerged: Number of frogs that emerged from each tank
       *Deaths: Number of frogs that died while held in captivity before official euthanasia
*Euthanized: Number of frogs that were euthanized from each tank. Survival to complete metamorphosis
       *Euthanized_Biomass: Sum of all biomass for euthanized frogs for each tank in grams
*Emergent_Biomass: Sum of biomass for all emerged frogs from each tank. Calculated by multiplying the average biomass per frog by the number of frogs that emerged. Measured in grams
       *Avg_Mass: Average individual metamorph dry mass per tank
*Pred_Invert: Presence of predaceous invertebrates (odonata, ranatra, bellostomatids, dytsicids, or hydrophilids)
	*1 = Presence of predaceous invertebrates
	*0 = Absence of predaceous invertebrates
       *First_Emerg: Day (experimental date) of first frog emergence
*Meta_Range: Range in the number of days frogs emerged from a single tank. Last day of frog emergence - first day of frog emergence
       *Size_Range: Range of size (in dry mass grams) from smallest to largest individual for each tank
       *Wmax: Parameter from Gompertz growth curve - Asymptote, maximum size. Units are grams.
       *K: Parameter from Gompertz growth curve - Growth rate. Units - g dry mass/day
*Xm: Parameter from Gompertz growth curve - day at which growth rate reaches its peak. Units measured in days.
       *Rsquare: R square value created from curve fitting the amphibian growth rate data in MatLab


Details for: Fish Data_Dryad.xlsx
---------------------------------------

* Description: A Microsoft Excel spreadsheet containing size and growth data for all fish within the study.

* Format(s): .xlsx

* Size(s): 24 KB

* Dimensions: 31 rows X 12 columns

* Variables:
       *Tank: Number used to identify the individual replicate experimental tanks
       *A_Pres: Amphibian presence. Yes or No.
       	*Y = amphibians present
       	*N = amphibians absent
       *Drying	Treatment: Denotes the drying treatment applied to that tank. 
       	*DR = Dry-refilled
       	*ND = Non-dried
*Treatment: Denotes the combination of tophic treatment and drying treatment applied to the experimental tank. 
		*A:DR = Amphibian only; Dry-refilled
		*A:ND = Amphibian only; Non-dried
		*F:DR = Fish only; Dry-Refilled
		*F:ND = Fish only; Non-dried
		*FA:DR = Fish and Amphibian; Dry-refilled
		*FA:ND = Fish and Amphibian; Non-dried
		*C:DR = Control (no fish or amphibian); Dry-refilled
		*C:ND = Control (no fish or amphibian); Non-dried
       *Initial_Date: Date that initial fish standard length was collected
       *Initial_SL: Initial standard length of fish in centimeters
*Initial_Biomass: Biomass in grams based on Youngmeyer length-weight regression where a=0.0315 and b=2.8765
       *Final_Date: Date that final fish standard length was collected
       *Final_SL: Final standard length of fish in centimeters
*Final_Biomass: Biomass in grams based on Youngmeyer length-weight regression where a=0.0315 and b=2.8765
       *Abs_SLGrowth	: Absolute growth calculated from final SL minus initial SL. Units = cm
       *Rel_SLGrowth: Relative growth calculated by (final SL - initial SL)/initial SL. Units = cm


Details for: Frog Metamorph Data.xlsx
---------------------------------------

* Description: A Microsoft Excel spreadsheet containing size and growth data on larval amphibians that survived to metamorphosis. This excel file contains the raw data collected for each individual frog that metamorphosed.

* Format(s): .xlsx

* Size(s): 40 KB

* Dimensions: 486 rows X 10 columns

* Variables:
       *Tank: Number used to identify the individual replicate experimental tanks
*Treatment: Denotes the combination of tophic treatment and drying treatment applied to the experimental tank. 
		*A:DR = Amphibian only; Dry-refilled
		*A:ND = Amphibian only; Non-dried
		*F:DR = Fish only; Dry-Refilled
		*F:ND = Fish only; Non-dried
		*FA:DR = Fish and Amphibian; Dry-refilled
		*FA:ND = Fish and Amphibian; Non-dried
		*C:DR = Control (no fish or amphibian); Dry-refilled
		*C:ND = Control (no fish or amphibian); Non-dried
       *Indiv: The number assigned to each individual frog upon metamorphosis
       *Date: The date that the data were collected
*Day: The experimental day (# of days since the experiment began). Days past Day 0. Day 0 = 5/8/2021.
       *Wet_Mass: Weight of live frog in grams
       *SVL: Snout vent length of live frog in millimeters
       *Cup_Mass: Weight of cup used to measure the dried frog in grams
       *Final_Mass: Combined weight of dried frog and drying cup in grams
       *Dry_Mass: Mass of dried frog (subtracting the drying cup) in grams


Details for: Periphyton Data_Dryad.xlsx
---------------------------------------

* Description: A Microsoft Excel spreadsheet containing all data relating to periphyton collection and calculations.

* Format(s): .xlsx

* Size(s): 84 KB

* Dimensions: 1153 rows X 12 columns

* Variables:
       *Tank: Number used to identify the individual replicate experimental tanks
*Trophic_Treatment: Denotes the trophic treatment applied to that tank (amphibian only, fish only, fish and amphibian, or control with no vertebrates)
*Drying_Treatment: Denotes the drying treatment applied to that tank (ether dry-refilled or non-dried). 
*Treatment: Denotes the combination of tophic treatment and drying treatment applied to the experimental tank. 
		*A:DR = Amphibian only; Dry-refilled
		*A:ND = Amphibian only; Non-dried
		*F:DR = Fish only; Dry-Refilled
		*F:ND = Fish only; Non-dried
		*FA:DR = Fish and Amphibian; Dry-refilled
		*FA:ND = Fish and Amphibian; Non-dried
		*C:DR = Control (no fish or amphibian); Dry-refilled
		*C:ND = Control (no fish or amphibian); Non-dried
*Location: Location on tank where sample was scraped. Front = South, back = North, left = West, right = East
       *Date: Date that the data were collected
*Day: The experimental day (# of days since the experiment began). Days past Day 0. Day 0 = 5/8/2021.
       *Per_Initial: Weight of filter paper used to collect the periphyton sample. Measured in grams
       *Per_Final: Weight of periphyton sample and filter paper after drying. Measured in grams
       *Lost_Weight: Amount of weight lost from filter paper during drying. Measured in grams
*Sample_Mass: Final mass of periphyton sample from 70 mm x 70 mm scraping after being dried down. Measured in grams
       *P_Mass: Periphyton mass in grams/m2 extrapolated by multiplying the sample mass X 204.8.
       204.8 is the conversion factor for area of sample to 1 m2. Units = grams


Details for: Revised YSI Data_Dryad.xlsx
---------------------------------------

* Description: A Microsoft Excel spreadsheet containing all data relating to dissolved oxygen and gross primary productivity collection and calculations.

* Format(s): .xlsx

* Size(s): 330 KB

* Dimensions: 1537 rows X 23 columns

* Variables:
       *Tank: Number used to identify the individual replicate experimental tanks
*Trophic_Treatment: Denotes the trophic treatment applied to that tank (amphibian only, fish only, fish and amphibian, or control with no vertebrates)
*Drying_Treatment: Denotes the drying treatment applied to that tank (ether dry-refilled or non-dried). 
*Treatment: Denotes the combination of tophic treatment and drying treatment applied to the experimental tank. 
		*A:DR = Amphibian only; Dry-refilled
		*A:ND = Amphibian only; Non-dried
		*F:DR = Fish only; Dry-Refilled
		*F:ND = Fish only; Non-dried
		*FA:DR = Fish and Amphibian; Dry-refilled
		*FA:ND = Fish and Amphibian; Non-dried
		*C:DR = Control (no fish or amphibian); Dry-refilled
		*C:ND = Control (no fish or amphibian); Non-dried
       *Date: Date that the data were collected
*Day: The experimental day (# of days since the experiment began). Days past Day 0. Day 0 = 5/8/2021.
*Temp_PM: Evening sample of water temperature of each tank in degrees Celcius
*PerDO_PM: Evening measure of dissolved oxygen. Units are percentage out of 500.
*DO_PM: Evening measure of dissolved oxygen. Converted units from percentage to mg/L.
*Conductivity_PM: Evening measure of conductivity. Units are microsiemens per centimeter.
*Temp_AM: Morning sample of water temperature of each tank in degrees Celcius
*PerDO_AM: Morning measure of dissolved oxygen. Units are percentage out of 500.
*DO_AM: Morning measure of dissolved oxygen. Converted units from percentage to mg/L.
*Conductivity_AM: Morning measure of conductivity. Units are microsiemens per centimeter.
*GPP: Absolute values of a relative measure of gross primary productivity measured by |(DOpm - DOam)|. Units are mg/L.
*GPPwNegs: Relative measure of gross primary productivity. Calculated by (DO_PM - DO_AM). Includes negative numbers.
*AM: Morning start time. Units are clock hours (12-hour).
*PM: Evening start time. Units are clock hours (12-hour). 
*Hrs: The number of hours between morning and evening sample times
*dDO_hr: GPP divided by number of hours between samples (provides hourly rate of GPP). Units are mg/L/hr	
*area m2: Surface area of the experimental tank. Units are m^2
*DO_m2_hr: Measurement of dissolved oxygen correcting for surface area of experimental tanks by taking hourly GPP rate and dividing by surface area in m2. Units are mg/L/hr/m^2
*GPP_Abs_Val: Absolute values of DO_m2_hr (abs value of dissolved oxygen per meter squared per hour)


Details for: Amphibian Analyses_Dryad.Rmd
---------------------------------------

* Description: An R markdown file containing all statistical analyses relating to the amphibian data. The Amphibian Biomass_Dryad.xlsx, Emergence and Biomass_Dryad.xlsx, and Frog Metamorph Data.xlsx files are analyzed within this R script. 

* Format(s): .Rmd

* Size(s): 16 KB

* Packages required: (readxl), (ggplot2), (MASS), (car), (multcomp), (lattice), (effects), (hrbrthemes), (dplyr), (tidyr), (viridis), (ggformula)


Details for: Fish Analyses_Dryad.Rmd
---------------------------------------

* Description: An R markdown file containing all statistical analyses relating to the fish data. The Fish Data_Dryad.xlsx file is analyzed within this R script.

* Format(s): .Rmd

* Size(s): 3 KB

* Packages required: (readxl), (ggplot2), (MASS), (car), (multcomp), (ggplot2), (lattice), (effects)


Details for: Periphyton Analyses_Dryad.Rmd
---------------------------------------

* Description: An R markdown file containing all statistical analyses relating to the periphyton data. The Periphyton Data_Dryad.xlsx file is analyzed within this R script.

* Format(s): .Rmd

* Size(s): 7 KB

*Packages required: (readxl), (ggplot2), (bbmle), (multcomp), (mgcv), (gamm4), (tidyverse), (mgcViz), (nlme), (gratia), (tidyr), (dbplyr), (itsadug), (mgcViz), (scales)


Details for: Revised YSI Analyses_Dryad.Rmd
---------------------------------------

* Description: An R markdown file containing all statistical analyses relating to the dissolved oxygen and gross primary productivity data. The Revised YSI Data_Dryad.xlsx file is analyzed within this R script.

* Format(s): .Rmd

* Size(s): 7 KB

*Packages required: (readxl), (ggplot2), (bbmle), (multcomp), (mgcv), (gamm4), (tidyverse), (mgcViz), (nlme), (gratia), (tidyr), (dbplyr), (itsadug), (mgcViz), (scales)


##Abstract:
We investigated the legacy effects of drying and refilling of wetlands via mesocosms on growth and survival of recolonizing aquatic vertebrates and their subsequent effects on ecological function. Specifically, we tested the effects of prior drying on anuran and fish growth and survival (using Gompertz growth curves), and joint effects of vertebrates and drying on periphyton biomass, and whole-system gross primary productivity. Using 64 1,000-L hard plastic cattle tanks to create replicate aquatic mesocosms, four trophic treatments (no vertebrate control, larval anurans, fish, larval anurans and fish) were crossed with two drying treatments (undried and dried-refilled) to simulate different outcomes of colonization by two common vertebrate guilds and drying/refilling cycles. Mesocosms with anuran treatments received 50 Lithobates blairi tadpoles (1,600 total) and mesocosms with fish treatments received one Lepomis cyanellus juvenile (32 total). We recorded anuran growth rates, survival, and time/size at metamorphosis, fish growth, gross primary productivity, and periphyton biomass over 12 weeks from 9 May 2021 to 1 August 2021.

Prior drying strongly reduced L. blairi growth rate by 38.2% but increased survival from 48.5 to 75%, resulting in relatively equal emergent anuran biomass between the two drying treatments. No L. blairi survived to metamorphosis when co-occurring with fish (i.e., larval anurans and fish treatment). On average, prior drying reduced the size at metamorphosis by 35.5%, delayed time to metamorphosis by 4 days, and increased the range of metamorphosis days by 10 days. Fish growth and survival were unaffected by trophic or drying treatments. Gross primary production and periphyton biomass decreased in response to prior drying and the presence of larval anurans, but these effects were non-constant over time.

## Description of the data and file structure

This dataset contains 4 R script files (one for each of the 4 companents of this study: Amphibians, fish, gross primary productivity, and periphyton) along with their corresponding Excel files. Survival for each tank was calculated as the total number of emerged frogs from weeks 1-12 divided by 50 (initial number of larvae per tank). Size at metamorphosis was determined by dry mass (g) measured after 72 hours in a drying oven at 60° C. Metamorph dry mass and wet mass were strongly correlated (grams dry mass = 0.1957*grams wet mass – 0.0398; R² = 0.9733) and we chose dry mass for size at metamorphosis to reduce variability caused by water weight. We measured the dry mass of metamorphosed frogs to the nearest 0.01g. Time to metamorphosis was measured as the days past the first day of the experiment (9 May 2021) to the day the frog reached Gosner stage 46 (Gosner, 1960). We calculated relative fish growth as the change in standard length (SL) over the duration of the experiment divided by the initial SL for each fish. Individual fish growth calculations used each of the single fish per tank as independent replicates. Relative fish growth measurements for fish within the same treatments (n = 8) were combined and analyzed together.Gross primary productivity values were collected by measuring dissolved oxygen (DO) values after sunset for maximum DO and before sunrise for minimum DO. DO measurements were collected using a YSI meter (ProQuatro XA00088 – 02; YSI Inc., Yellow Springs, OH, USA) as a percentage out of 500.  

All data were collected in the field at the location of the experimental study. All field data were entered into Excel sheet format and subsequently analyzed via the R Studio software program. The only modification to the collected data is the following: data from tank #1 omitted from periphyton and gross primary productivity analyses due to a separate amphibian species ovipositing within that tank. 


## Reusability 
We state that this data including all R code within the .Rmd files are available for reuse or copy.
