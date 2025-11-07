using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

// NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService" in both code and config file together.
[ServiceContract]
public interface IService
{

	[OperationContract]
	string GetData(int value);

	[OperationContract]
	CompositeType GetDataUsingDataContract(CompositeType composite);

	// Conversiones de Temperatura
	[OperationContract]
	double CelsiusToFahrenheit(double celsius);

	[OperationContract]
	double FahrenheitToCelsius(double fahrenheit);

	[OperationContract]
	double CelsiusToKelvin(double celsius);

	// Conversiones de Masa
	[OperationContract]
	double KilogramsToPounds(double kilograms);

	[OperationContract]
	double PoundsToKilograms(double pounds);

	[OperationContract]
	double KilogramsToOunces(double kilograms);

	// Conversiones de Longitud
	[OperationContract]
	double MetersToFeet(double meters);

	[OperationContract]
	double FeetToMeters(double feet);

	[OperationContract]
	double KilometersToMiles(double kilometers);
}

// Use a data contract as illustrated in the sample below to add composite types to service operations.
[DataContract]
public class CompositeType
{
	bool boolValue = true;
	string stringValue = "Hello ";

	[DataMember]
	public bool BoolValue
	{
		get { return boolValue; }
		set { boolValue = value; }
	}

	[DataMember]
	public string StringValue
	{
		get { return stringValue; }
		set { stringValue = value; }
	}
}
