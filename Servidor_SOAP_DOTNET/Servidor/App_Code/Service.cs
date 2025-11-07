using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

public class Service : IService
{
    public string GetData(int value)
    {
        return string.Format("You entered: {0}", value);
    }

    public CompositeType GetDataUsingDataContract(CompositeType composite)
    {
        if (composite == null)
        {
            throw new ArgumentNullException("composite");
        }
        if (composite.BoolValue)
        {
            composite.StringValue += "Suffix";
        }
        return composite;
    }

    // Temperature conversion implementations
    public double CelsiusToFahrenheit(double celsius)
    {
        return (celsius * 9/5) + 32;
    }

    public double FahrenheitToCelsius(double fahrenheit)
    {
        return (fahrenheit - 32) * 5/9;
    }

    public double CelsiusToKelvin(double celsius)
    {
        return celsius + 273.15;
    }

    // Mass conversion implementations
    public double KilogramsToPounds(double kilograms)
    {
        return kilograms * 2.20462;
    }

    public double PoundsToKilograms(double pounds)
    {
        return pounds / 2.20462;
    }

    public double KilogramsToOunces(double kilograms)
    {
        return kilograms * 35.274;
    }

    // Length conversion implementations
    public double MetersToFeet(double meters)
    {
        return meters * 3.28084;
    }

    public double FeetToMeters(double feet)
    {
        return feet / 3.28084;
    }

    public double KilometersToMiles(double kilometers)
    {
        return kilometers * 0.621371;
    }
}
