#Joaquin_Lim_limjoaqu_1008463440

#define sets
set I; #number of unique shoes
set J; #number of machines
set K; #number of unique raw materials
set L; #number of warehouses

#define parameters
param qtyReq{I,K} default 0; #amnt of raw material K, needed to make a pair of shoe type I
param costRM{K}; #cost of a unit of raw material K
param qtyAvail{K}; #amnt of raw material K available monthly
param avgDuration{I,J} default 0; #average length of time required to make shoe type I with machine J
param opCost{J}; #cost of operating machine J for a minute
param demand{I}; #demand for shoe type I for Feb2006
param priceSale{I}; #sale price for shoe type I
param capacity{L}; #maximum capacity of warehouse L

#define decision variables
var x{I}  >= 0; #number of type I shoes
var y{J}  >= 0; #number of minutes worked in a month at machine J
#var z{I} >= 0; #uncomment to answer Q5: number of additional shoes of type I to fill purchased warehouse space 

#Objective function
maximize Profit: (sum{i in I} x[i]*priceSale[i]) #revenue from shoe sales
- (sum{j in J} opCost[j]*y[j]) #operating time expenses
- 10*(sum{i in I} (2*demand[i]-x[i])) #opportunity cost from failed demands
- (25/60)*(sum{j in J} y[j]) #workers' wages
- (sum{i in I, k in K} x[i]*qtyReq[i,k]*costRM[k]); #RM expenses

#define constraints
subject to budgetRM: sum{i in I, k in K} x[i]*qtyReq[i,k]*costRM[k] <= 10000000; #Q7: replace with subject to budgetRM: sum{i in I, k in K} x[i]*qtyReq[i,k]*costRM[k] <= 17000000; 
subject to maxMachTime{j in J}: y[j] <= (60*12*28); #Q6: replace with subject to maxMachTime{j in J}: y[j] <= (60*8*28);
subject to maxWarehouse: sum{i in I} x[i] <= sum{l in L} capacity[l];
subject to maxRMQty {k in K}: sum{i in I} qtyReq[i,k]*x[i] <= qtyAvail[k];
subject to machShoeEquality {j in J}: sum{i in I} (1/60)*avgDuration[i,j]*x[i] = y[j]; 
