# TimeSeriesForecastingProphet
R studio code to forecast and visualize Indonesia and China Covid Case January-May 2020

We get raw data that we called covid_19_clean_complete.csv

![image](https://user-images.githubusercontent.com/39585151/129004675-36039ddf-71be-4aff-bfa3-860ff82fa49e.png)

First step we need to preprocess data , we just need Indonesia and China data, Confirmed column, Deaths column and Recovered column.

![image](https://user-images.githubusercontent.com/39585151/129005346-c8a10dc8-fa3a-40e7-bac4-5d619b6ac507.png)

After get the clean data, we can start visualize data with bbplot function
![image](https://user-images.githubusercontent.com/39585151/129005746-525a37b7-4f58-4300-80d2-7f46e2622fa1.png)
![image](https://user-images.githubusercontent.com/39585151/129005793-2ee887ab-183d-47d8-b3d0-21ce8bb148bc.png)
![image](https://user-images.githubusercontent.com/39585151/129005669-a3814f2a-337b-49b0-ae79-d46fec24b7f7.png)

After visualize case data, we need to visualize active case by date


![gunung cina](https://user-images.githubusercontent.com/39585151/129006248-6562e9ef-411d-4fd0-b6c7-64cda93cc274.png)
![gunung indonesia](https://user-images.githubusercontent.com/39585151/129006251-a322cbd0-87e1-4b72-bd11-81424185ad53.png)

There's so many machine learning that we can use to forecast data, in this case we use machine learning prophet from facebook to forecast the data
We can see result from forecast in the picture below

![image](https://user-images.githubusercontent.com/39585151/129006923-2f1dcb8c-6e79-472a-98d6-c117713199ca.png)
![image](https://user-images.githubusercontent.com/39585151/129006969-70dd0b2b-8eb6-4350-bd84-c532ba1c35b0.png)



