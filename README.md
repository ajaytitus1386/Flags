<p align="center">
  <a href="">
    <img alt="countries_icon" src="./assets/images/flag.png" width="120" />
  </a>
</p>

# Flags Task

A Flags Task made for Nearcast

- [Flags Task](#flags-task)
  - [Getting Started](#getting-started)
  - [Architecture](#architecture)
    - [Data Layer](#data-layer)
    - [Presentation Layer](#presentation-layer)
  - [The User Interface Flow](#the-user-interface-flow)

## Getting Started

1.  Install Flutter by following the official instruction at [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
    &nbsp;

2.  Clone this repo using the link

    ```shell
    git clone https://github.com/ajaytitus1386/Flags.git
    ```

3.  Go to the root of the project and get the dependencies
    ```shell
    flutter pub get
    ```
4.  Next, run the on a connected device using
    ```shell
    flutter run
    ```

## Architecture

The project follows a simple two-tier architecture consisting of Data and Presentation layers

### Data Layer

This layer handles both remote data calls and storage with local data sources.

- **db** : Helper class and methods for database
- **models** : Models of Data Objects and conversion logic to and from JSON
- **providers** : Holds the API handler class to fetch data
- **services** : Other business logic

### Presentation Layer

Focuses on Flutter layout and the Widget Tree. Anything and everything to do with the UI is structured here

- **pages** : The individual views of the UI
- **widgets** : Reusuable and Extractable widget components
- **styling** : Constants for Colors, TextStyles, Sizes and so on

## The User Interface Flow

The current build flows between two main pages: The Home Page and the Region Page

**The Home Page**: The landing page of the app. Displays the regions of the world as cards.

**The Region Page**: Using the stored data, displays a list of countries based on a region as vertical tiles.

**The Country Page**: Tapping on a country tile, displays its bordering countries and the language spoken in the country
