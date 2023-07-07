<a name="readme-top"></a>
<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]
[![Trailhead][trailhead-shield]][trailhead-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/brunagirao/opencagegeocoder-account-trigger">
    <img src="https://github.com/brunagirao/opencagegeocoder-account-trigger/assets/30693791/5853a777-5fd7-439c-8e9a-78c3b83e4cc6" alt="Logo" width="600" height="300">
  </a>

<h3 align="center">OpenCage Geocoder API | Salesforce Account Object</h3>

  <p align="center">
    A project where, through the OpenCage API, we can fill in the Location/Address information in the Account object records in Salesforce.
    <br />
    <a href="https://github.com/brunagirao/opencagegeocoder-account-trigger"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/brunagirao/opencagegeocoder-account-trigger">View Demo</a>
    ·
    <a href="https://github.com/brunagirao/opencagegeocoder-account-trigger/issues">Report Bug</a>
    ·
    <a href="https://github.com/brunagirao/opencagegeocoder-account-trigger/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <!--  
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li> -->
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

- In this project, I integrate the [Salesforce CRM](https://www.salesforce.com/br/?ir=1) with the 3rd party API [OpenCage Geocoding API](https://opencagedata.com/api).
- **About OpenCage Geocoding API:** this API provides worldwide, _**reverse** (latitude/longitude to text)_ and _**forward** (text to latitude/longitude)_ geocoding based on open data via a REST API. For this project I used these two resource, doing a single implement for each one.
- **About Salesforce:** I created the **OpenCageGeocoderService** class responsible to call the 3rd party API and the **AccountTrigger** responsible for call the service class each time that an Account record is created or update.  


[![Account Record | Geolocation and Address Information][product-screenshot]](https://example.com)



<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

* [![Salesforce][Salesforce]][Salesforce-url]
* [![OpenCage-Geocoder-API][OpenCage-Geocoder-API]][OpenCage-Geocoder-API-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

For this project, you need a **[Salesforce Developer Edition](https://developer.salesforce.com/signup).**

### Installation

1. Get a free **API Key** at [OpenCage API - Quick Start](https://opencagedata.com/api#quickstart)
2. Clone the repo in your VS Code or IntelliJ
   ```sh
   git clone https://github.com/brunagirao/opencagegeocoder-account-trigger.git
   ```
3. Deploy all the code and configs in your **[Salesforce Developer Edition](https://developer.salesforce.com/signup).**
4. On Salesforce, go to Setup > Custom Settings > Select Open Cage Geocoder Settings
   ![image](https://github.com/brunagirao/opencagegeocoder-account-trigger/assets/30693791/50fc0aff-7218-4c56-97be-d54da394eb73)
5. On Open Cage Geocoder Settings > Click Manage > Click in New > Create the Open Cage Geocoder Settings below
   ![image](https://github.com/brunagirao/opencagegeocoder-account-trigger/assets/30693791/fe67ab69-cbe4-479d-9600-b91d4d0f7245)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES 
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_
 
<p align="right">(<a href="#readme-top">back to top</a>)</p> -->



<!-- ROADMAP 
## Roadmap

- [ ] Feature 1
- [ ] Feature 2
- [ ] Feature 3
    - [ ] Nested Feature

See the [open issues](https://github.com/brunagirao/opencagegeocoder-account-trigger/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p> -->



<!-- CONTRIBUTING 
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p> -->



<!-- LICENSE
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p> -->



<!-- CONTACT 
## Contact

Your Name - [Bruna's Trailhead](https://trailblazer.me/id/brunagirao)

Project Link: [OpenCage Geocoder API | Salesforce Account Object](https://github.com/brunagirao/opencagegeocoder-account-trigger)

<p align="right">(<a href="#readme-top">back to top</a>)</p> -->



<!-- ACKNOWLEDGMENTS 
## Acknowledgments

* []()
* []()
* []()

<p align="right">(<a href="#readme-top">back to top</a>)</p> -->



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/brunagirao/opencagegeocoder-account-trigger.svg?style=for-the-badge
[contributors-url]: https://github.com/brunagirao/opencagegeocoder-account-trigger/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/brunagirao/opencagegeocoder-account-trigger.svg?style=for-the-badge
[forks-url]: https://github.com/brunagirao/opencagegeocoder-account-trigger/network/members
[stars-shield]: https://img.shields.io/github/stars/brunagirao/opencagegeocoder-account-trigger.svg?style=for-the-badge
[stars-url]: https://github.com/brunagirao/opencagegeocoder-account-trigger/stargazers
[issues-shield]: https://img.shields.io/github/issues/brunagirao/opencagegeocoder-account-trigger.svg?style=for-the-badge
[issues-url]: https://github.com/brunagirao/opencagegeocoder-account-trigger/issues
[license-shield]: https://img.shields.io/github/license/brunagirao/opencagegeocoder-account-trigger.svg?style=for-the-badge
[license-url]: https://github.com/brunagirao/opencagegeocoder-account-trigger/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/brunagirao
[trailhead-shield]: https://img.shields.io/badge/-Trailhead-black.svg?style=for-the-badge&logo=trailhead&colorB=555
[trailhead-url]: https://trailblazer.me/id/brunagirao
[product-screenshot]: https://github.com/brunagirao/opencagegeocoder-account-trigger/assets/30693791/e3a53ad5-0408-422f-9239-2bca1729231b

[Salesforce]: https://img.shields.io/badge/salesforce-blue?style=for-the-badge&logo=Salesforce&logoColor=%2300A1E0
[Salesforce-url]: https://www.salesforce.com/
[OpenCage-Geocoder-API]: https://img.shields.io/badge/opencage%20geocoder%20API%20-%20%231a8865?style=for-the-badge&logoColor=%231a8865
[OpenCage-Geocoder-API-url]: https://opencagedata.com/
