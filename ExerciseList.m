%% Exercises.
% Copyright MathWorks Inc, 2016.
%
% This appendix contains several hands-on exercises designed to provide
% practice with the concepts covered during each section of the course.

%% Debugging and Improving Performance.
% Exercise - Debugging and Improving Existing Code
% Solution - analyzerEx_sol, analyzerEx_sol_vectorised
%
% * In this exercise, you will debug an existing code file. Open the 
%   function analyzerEx in the Editor and inspect the Code Analyzer 
%   warning messages.
%
% * Fix each of the Code Analyzer warnings, and call the function to 
%   ensure that the results are as expected.
%
% * Bonus: Improve the code by vectorising the double for-loop. 
%   Hint: look up the repmat function, or use matrix multiplication or the
%   cumsum function.

%% Monte Carlo GDP price simulation.
% One way of simulating a financial asset is to transform the observable 
% price series so that it is possible to identify the underlying random 
% process. After that, the next step is to generate random sequences from 
% that process and transform them back to price series. These price 
% curves can then be analyzed in various ways. In this exercise, the goal 
% is to improve the performance of the sequential code.
%
% * Inspect the original version of the code, randsim.m, and run it using 
%   2000 simulations. 
% * Rerun the code in the MATLAB Profiler to see the bottlenecks.
% * Save the original file randsim.m as "randsimVec.m" so that you can
%   modify the code without altering the original version.
% * Adjust the code in the simulations subfunction for performance by 
%   generating a vector of random numbers instead of one random number at 
%   a time, thereby removing the inner for-loop.
% * Run the modified version of the code and compare the timings.
%   Ensure that the results are comparable to those obtained running the 
%   original code.

%% Function handles.
%
% * Create a function handle to represent the function g(x) = x.*sin(x).
% * Plot this function over the domain [-4*pi, 4*pi] using ezplot.
% * Find a root of this function near x0 = pi/2 using fzero. Add this point
%   to the plot.
% * What is the area under g between 0 and pi? Hint: use integral.
% * Create a function to represent the function f(x, y) = x.*y.*exp(-x.^2-y.^2).
% * Visualise this function as a surface using ezsurf and the default
%   domain.

%% Tables.
% Exercise - Gas Prices 
% Solution - Ex01_GasPrices.m 
%
% * Create a new script, and use the readtable function to import the data 
%   from gasprices.csv into a table in your Workspace. Hint: You will need 
%   to specify the Delimiter and Headerlines options – see the 
%   documentation for the readtable function.
%
% * Extract the data for Japan from the table into a separate numeric 
%   variable, using the dot syntax (.). Compute the mean and standard 
%   deviation of the Japanese prices.
%
% * Extract the data for Europe into a numeric array, and compute the mean
%   European price for each year. Hint: check the documentation for the 
%   mean function.
%
% * Compute the European return series from the prices using the following 
%   formula:
%
%       R(t) = log( P(t+1)/P(t) )
%
%   Here, P(t) represents a single price series. There are four price 
%   series in the European data.
%
% * Compute the correlation coefficients of the four European return 
%   series. Hint: See the documentation for the corrcoef function. Display 
%   the resulting correlation matrix using the imagesc function.

%% Population dynamics.
%
% The number of individuals in a population at a given time step can be 
% modelled by the following equation:
% x_{n+1} = x_n + R*x_n*(C-x_n)/C,
% where R represents the reproduction rate of the population, and C 
% represents the carrying capacity of the environment (the number of 
% individuals an environment can support).
% 
% * Run the following code in MATLAB to see how the population changes as 
%   the reproduction rate varies.
%
% initPop = 5000;
% Rminmax = [1.5, 3.0];
% Rstep = 1e-5;
% numsteps = 1200;
% capacity = 10000;
% cycles = popdynamics(initPop, Rminmax, Rstep, numsteps, capacity);
%
% figure
% Rvec = Rminmax(1):Rstep:Rminmax(2);
% plot(Rvec, cycles)
%
% * Modify the popdynamics.m code to run on multiple instances of MATLAB.  
% * Run the modified version and plot the results. Verify that the results 
%   match those obtained using a single instance of MATLAB.
% * Use the tic/toc functions (or otherwise) to compute the speedup
%   obtained by using parallel processing on this problem.

%% Gene matching.
%
% * Use the gunzip command to extract the data file gene.txt contained in 
%   the archive gene.txt.gz.
%
% * Invoke the (sequential) genematch function using the following syntax:
%   >> [bestPercentMatch, matchStartIndex] = genematch('gattaca', 'gene.txt');
%
% * Open the file pargenematch in the MATLAB Editor. The next steps are 
%   described in the TODO comments contained in this file. Run the function
%   pargenematch to offload the gene matching computation as a parallel
%   job.

%% Parallel image filtering.
%
% * Open the file parallelImageReadStart.m in the MATLAB Editor and examine
%   its contents. The code reads in a noisy image and applies the median 
%   filtering algorithm to remove the noise.
% * Modify the code to read the image data in parallel, following the TODO
%   steps within the function. Test the parallel algorithm using the
%   "MarsNoisy.tif" image as the input.

%% Advanced MATLAB graphics.
% Exercise - House Prices to Median Earnings
% Solution - PricesToWages, plotPrices_sol, houseUI_complete
%
% * Create a new script, and load the data from House.mat into the 
%   Workspace.
%
% * Open and view the data table in the Variable Editor. Extract the region
%   names from the table as a cell array of strings, by accessing the 
%   Properties metadata of the table. Hint: At the command line, enter 
%   >> pricesToWages.Properties
%
% * Use the strcmp function and the cell array from the previous step to 
%   identify the row of the table containing the data for York. 
%   Extract the data from this row, and plot this data as a function of 
%   year (note that the years range from 1997 to 2012).
%
% * Write a function plotPrices with the following specifications:
%
%   plotPrices accepts a row number as its only input argument;
%   plotPrices plots the price information from the corresponding row of 
%   the table as a function of year.
%
%   Note that since functions have their own private workspace, you will 
%   need to load the required data inside the function.
%
% * Open the houseUI function file and modify the popup menu 
%   callback so that the plot is updated when the user selects a region 
%   of interest.

%% Exploratory data analysis.
%
% * Load quakes14.mat. This file contains a table of earthquake data for 14
%   countries through the 20th century. The data includes the date and time
%   of the quake, its magnitude, location, and impact (in terms of life and
%   cost).
% * Make a histogram of earthquake magnitudes. Calculate the skewness and 
%   kurtosis, and compare them to the skewness and kurtosis of a normal 
%   distribution (0 and 3, respectively).
% * Repeat step 2 with just Japanese earthquakes.
% * Use grpstats to calculate the mean magnitude for each country.
% * Sort the countries by mean magnitude. Hint: Use the categories function
%   to get the country names.
% * Make a boxplot of magnitudes grouped by country. Does this agree with 
%   your findings above?
% * Make a scatter plot of the logarithm of the number of deaths and the 
%   logarithm of the damage cost. (These variables have a highly 
%   exponential distribution; taking the logarithm makes visualization of 
%   their relationship clearer.) Calculate the correlation coefficient.

%% Probability distributions.
%
% * Load quakes14.mat. This file contains a table of earthquake data for 14
%   countries through the 20th century. The data includes the date and time
%   of the quake, its magnitude, location, and impact (in terms of life and
%   cost).
% * Make a histogram of earthquake magnitudes. It can be difficult to 
%   determine if data is normally distributed from a histogram alone.  
%   Make a normal probability plot and use an appropriate test to determine
%   whether magnitudes are normally distributed.
% * Repeat step 2 with just Japanese earthquakes, and again with just 
%   Turkish earthquakes.
% * Fit normal distributions to the Japanese and Turkish earthquake 
%   magnitudes.
% * Compare the two distributions by plotting their pdfs on the same set 
%   of axes.

%% Curve-fitting and regression.
% * Load WCgoals.mat. This file contains a record of the number of goals 
%   and number of matches played in each FIFA World Cup™.
% * Make a plot of the average number of goals per match, as a function of 
%   year.
% * Calculate two best-fit trendlines: one for the entire data set, and the
%   other for just the World Cups from 1962 onward. Overlay both lines on 
%   the plot.
% * Make normal probability plots of the residuals from both fits. Are the
%   residuals normally distributed?

%% The MATLAB Language and Desktop Environment.
% Exercise - Australian Marriages 
% Solution - Ex02_AusMarriages 
%
% * Create a new script, and use the readtable function to import the data
%   from AusMarriages.dat into a table in your Workspace. Hint: You will 
%   need to specify the Delimiter option – see the documentation for the 
%   readtable function. This data file is tab-delimited ('\t').
%
% * Insert an additional variable dn in the table containing the numerical 
%   representations of the dates. Hint: MATLAB uses serial date numbers to
%   represent date and time information. Check the documentation for the 
%   datenum function (note that the date format for this data is 
%   dd/mm/yyyy).
%
% * Plot the number of marriages as a function of time. Format the x-axis 
%   tick labels using the datetick function.
%
% * Create a 1x25 row vector v of equal values 1/25. Hint: use ones.
%
% * Use the conv function (with the 'same' option) and the vector from 
%   step 4 to smooth the marriage data.
%
% * Overlay the smoothed data on the original plot, using a different 
%   colour. Hint: Use hold on.

%% Algorithm Design in MATLAB.
% Exercise - Pacific Sea Surface Temperatures 
% Solution - Ex03_SeaSurfaceTemperatures, SST_grid_sol
%
% * Create a new script, and load the data from Ex03_SST.mat into the 
%   Workspace.
%
% * Visualise the first set of temperature data (corresponding to the first
%   column of the variable sst) using: a 2D scatter plot, specifying the 
%   colours using the temperature data; a 3D scatter plot, using black 
%   points as markers.
%
% * Create equally-spaced vectors of points ranging from min(lon) to 
%   max(lon) and min(lat) to max(lat), respectively. Next, create grids 
%   lonGrid and latGrid of lattice points using meshgrid.
%
% * Create a variable tempGrid by interpolating the first set of 
%   temperature data over the lattice of points created in the previous 
%   step. Hint: use griddata.
%
% * Visualise the resulting interpolated values using the surf function.
%
% * Write a function SST_grid taking the longitude, latitude and a set of 
%   temperature measurements as its three input arguments. The function 
%   should return lonGrid, latGrid and tempGrid as output arguments. 
%   Therefore, the first line of your function will be:
%
% [lonGrid, latGrid, tempGrid] = SST_grid(lon, lat, seaTemp)
%
% * In your script, invoke your function for each different set of sea 
%   surface temperature measurements (i.e. the different columns of the 
%   sst variable), and visualise the results in a 4x6 subplot array. 
%   Hint: use a for-loop and the subplot function.

%% Test and Verification of MATLAB Code.
% Exercise - String Subset Replacement 
% Solution - test_repblank_sol
%
% * Open the script app_repblank and run the code. The objective of this 
%   exercise is to write unit tests for the repblank function. Open the 
%   repblank function and read the help to understand the function's 
%   specifications and requirements.
%
% * Open the main test function test_repblank. This main test function 
%   currently has four local test function stubs.
%
% * Write code in the test_OneBlank local test function to verify that 
%   repblank exhibits correct behaviour when the input string contains one 
%   blank character (i.e. one space). Hint: use verifyEqual.
%
% * Write code in the test_ManyBlank local test function to verify that 
%   repblank exhibits correct behaviour when the input string contains 
%   multiple consecutive blank values.
%
% * Write code in the test_FirstBlank local test function to verify that 
%   repblank exhibits correct behaviour when the input string contains 
%   leading spaces.
%
% * Write code in the test_LastBlank local test function to verify that 
%   repblank exhibits correct behaviour when the input string contains 
%   trailing spaces.
%
% * Run all tests using the runtests command and ensure that all tests 
%   pass.
%
% * Bonus: write another local test function to verify that repblank 
%   throws an error when called with a string consisting entirely of 
%   blanks. Hint: use verifyError with an appropriate error identifier.
%   Ensure that all tests still pass as before.

%% Test and Verification of MATLAB Code.
% Exercise - Levenshtein String Distances
% Solution - test_strdist_sol
%
% * Open the script app_strdist and run the code. The objective of this 
%   exercise is to write unit tests for the strdist function. Open the 
%   strdist function and read the help to understand the function's 
%   specifications and requirements.  
%
% * Open the main test function test_strdist. This main test function 
%   currently has a setupOnce method, a teardownOnce method and three 
%   local test function stubs.
%
% * Write code in the setupOnce method which adds the test data folder 
%   STRDIST_Test_Data to the path, and then initialises the TestData 
%   structure contained in the testCase object by loading the MAT-file 
%   words.mat.
%
% * Write code in the teardownOnce method which removes the test data 
%   folder STRDIST_Test_Data from the path.
%
% * Write code in the test_OneWord local test function to verify that 
%   strdist exhibits correct behaviour when called with only the first 
%   word from the words.mat MAT-file. (In this case, the expected answer 
%   is 0.)
%
% * Write code in the test_ThreeWords local test function to verify that 
%   strdist exhibits correct behaviour when called with the first three 
%   words from the words.mat MAT-file. (In this case, the expected answer 
%   is the row vector [7, 5, 7].)
%
% * Write code in the test_DimensionsOutput local test function to verify
%   that strdist returns a solution of the correct dimensions when called 
%   with the first four words from the words.mat MAT-file. (In this case, 
%   the expected answer is the row vector [1, 6].) 

%% Test and Verification of MATLAB Code.
% Exercise - Counting Word Frequencies
% Solution - test_getwords_sol
%
% * Open the script app_getwords and run the code. The objective of this 
%   exercise is to write unit tests for the getwords function. Open the
%   getwords function and read the help to understand the function's 
%   specifications and requirements.  
%
% * Open the main test function test_getwords. This main test function 
%   currently has a setupOnce method, a teardownOnce method and three 
%   local test function stubs.
%
% * Write code in the setupOnce method which adds the test data folder 
%   Literature to the path.
%
% * Write code in the teardownOnce method which removes the test data 
%   folder Literature from the path.
%
% * Write code in the test_IncorrectFilename local test function to verify 
%   that getwords exhibits correct behaviour when called with a 
%   non-existent file. Hint: use verifyError. In this case, the expected 
%   error ID is getwords:noFile.
%
% * Write code in the test_AllWords local test function to verify that the 
%   first output of getwords has the correct size when the function is 
%   called on the file 'sherlock_holmes.txt'. In this case, the expected 
%   size of W is [207, 1]. Hint: use verifySize.
%
% * Write code in the test_MaxFreq local test function to verify that 
%   getwords correctly returns the frequency of the most common word in 
%   'sherlock_holmes.txt'. The most common word in 'sherlock_holmes.txt' 
%   occurs with frequency 10.  Hint: use verifyEqual.

