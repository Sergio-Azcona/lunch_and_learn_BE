![alt text](app/assets/LnL_logo.webp)

<br>
<details>
  <summary>Lunch and Learn Table of Contents</summary>
  <ul list-style-position="inside">
    <li>
      <a href="#lunch-and-learn-app-overview">Lunch and Learn App Overview</a>
      <ul>
        <li><a href="#learning-goals">Learning Goals</a></li>
        <li><a href="#apis-consumed">APIs Consumed</a></li>
        <li><a href="#schema">Schema</a></li>
      </ul>
    </li>
    <li>
      <a href="#specs-and-deployment-instructions">Specs and Deployment instructions</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li>
      <a href="#usage">Usage</a>
      <ul>
        <li><a href="#endpoints">Endpoints</a></li>
      </ul>
    </li>
  </ul>
</details>

<!-- LUNCH AND LEARN APP OVERVIEW -->
## Lunch and Learn App Overview
The overarching goal of the project is to allow users to explore cuisines through a simple country search, save their favorite recipes for later, and provide educational material related to the cuisine's country. 

The project is designed using Service Oriented Architecture, with this app serving as the backend service.

### Learning Goals
<ul>
  <li>Expose an API that aggregates data from multiple external APIs</li>
  <li>Expose an API that requires an authentication token</li>
  <li>Expose an API for CRUD functionality</li>
  <li>Test, both, API consumption and exposure using a mocking tool (Webmock)</li>
</ul>

### APIs Consumes
<ul>
  <li>country input is varified by using Restcountries</li>
  <li>recipes from Edamam</li>
  <li>videos providing a brief history of the country from Youtube</li>
  <li>popular photo images of the country from Unsplash</li>
</ul>

### Schema
Users: A users must have a unique email address. We create an API key for each user. Users can have many favorite recipes. 

Favorites: we store the title, url, and the country that relates to the recipes.  

![alt text](app/assets/Readme_Lunch_N_Learn_Schema.png)

<!-- SPECS AND DEPLOYMENT INSTRUCTIONS -->
## Specs and Deployment instructions
Ruby & Rails version:
  ```
  Ruby '2.7.4'
  Rails 5.2.8.1
  ```

To run the app locally run the following 4 commands in your termianl :
1. Clone the app to your local pc: $ ```git clone git@github.com:Sergio-Azcona/lunch_and_learn_BE.git```
2. Set up the Gems & dependencies:  $ ```bundle install```
3. Database creation: $ ```rails db:{drop,create,migrage,seed}```
4. Run the server on localhost:3000: $ ```rails s```

Additionally, you can now run the test suite: $ ```bundle exec rspec spec```

## Endpoints

### Users
Creat a user: 
``` http://localhost:3000/api/v1/users ```


<details>
  <summary> Users</summary>
  <ul list-style-position="inside; no-bullets">
    <li>Users require a name and unique email address</li>
    <li>API Endpoint:``` http://localhost:3000/api/v1/users ```<li>    
    <li>Successful request/response: 
    ![alt text](app/assets/user_create_happy_path.png) </li>

    <li>Unsuccessful request:
    ![alt text](app/assets/user_create_sad_path.png) 
     </li>
  </ul>
</details>