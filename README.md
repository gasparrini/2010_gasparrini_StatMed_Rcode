### An introduction to distributed lag non-linear models and the R package dlnm

------------------------------------------------------------------------

An example of application of distributed lag non-linear models (DLNMs) in time series analysis. The example is similar to that included in the article:

Gasparrini A, Armstrong B, Kenward MG. Distributed lag non-linear models. *Statistics in Medicine*. 2010;29(21):2224-2234. DOI: 10.1002/sim.3940. PMID: 20812303. [[freely available here](http://www.ag-myresearch.com/2010_gasparrini_statmed.html)]

The article and code introduce the [R package dlnm](https://github.com/gasparrini/dlnm). Note that the syntax and usage of the functions have changed considerably since the version used for the original analysis, and the code has been updated accordingly.

The original example included in the article was based on data for the city of New York available from the National Mortality, Morbidity, and Air Pollution Study (NMMAPS), which at the time of the publication was available through the R package NMMAPSlite. Unfortunately, the data are not available any more and the package NMMAPSlite has been archived. This means that the analysis of the paper is not replicable. In order to provide a working example, the code has been replaced with a similar analysis on the same data for Chicago, which is available as the dataset `chicagoNMMAPS` through the package [dlnm](https://github.com/gasparrini/dlnm).

------------------------------------------------------------------------

The material:

-   *Rcode.R* performs the example

Download as a ZIP file using the green button *Clone or download* above
