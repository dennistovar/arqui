/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/GenericResource.java to edit this template
 */
package ec.edu.monster.ws;

import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.UriInfo;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.core.MediaType;

/**
 * REST Web Service
 *
 * @author Gio
 */
@Path("conversion")
public class ConversionUnidades {

    @Context
    private UriInfo context;

    public ConversionUnidades() {
    }


    // --------------------- NUEVAS CONVERSIONES ---------------------

    // 🔥 TEMPERATURA
    @GET
    @Path("/celsius-a-fahrenheit/{celsius}")
    @Produces(MediaType.TEXT_PLAIN)
    public double celsiusAFahrenheit(@PathParam("celsius") double celsius) {
        return (celsius * 9 / 5) + 32;
    }

    @GET
    @Path("/fahrenheit-a-celsius/{fahrenheit}")
    @Produces(MediaType.TEXT_PLAIN)
    public double fahrenheitACelsius(@PathParam("fahrenheit") double fahrenheit) {
        return (fahrenheit - 32) * 5 / 9;
    }

    @GET
    @Path("/celsius-a-kelvin/{celsius}")
    @Produces(MediaType.TEXT_PLAIN)
    public double celsiusAKelvin(@PathParam("celsius") double celsius) {
        return celsius + 273.15;
    }

    // ⚖️ MASA
    @GET
    @Path("/kg-a-gramos/{kg}")
    @Produces(MediaType.TEXT_PLAIN)
    public double kgAGramos(@PathParam("kg") double kg) {
        return kg * 1000;
    }

    @GET
    @Path("/gramos-a-miligramos/{gramos}")
    @Produces(MediaType.TEXT_PLAIN)
    public double gramosAMiligramos(@PathParam("gramos") double gramos) {
        return gramos * 1000;
    }

    @GET
    @Path("/toneladas-a-kg/{toneladas}")
    @Produces(MediaType.TEXT_PLAIN)
    public double toneladasAKg(@PathParam("toneladas") double toneladas) {
        return toneladas * 1000;
    }

    // 📏 LONGITUD
    @GET
    @Path("/km-a-m/{km}")
    @Produces(MediaType.TEXT_PLAIN)
    public double kmAMetros(@PathParam("km") double km) {
        return km * 1000;
    }

    @GET
    @Path("/m-a-cm/{m}")
    @Produces(MediaType.TEXT_PLAIN)
    public double metrosACentimetros(@PathParam("m") double m) {
        return m * 100;
    }

    @GET
    @Path("/cm-a-mm/{cm}")
    @Produces(MediaType.TEXT_PLAIN)
    public double centimetrosAMilimetros(@PathParam("cm") double cm) {
        return cm * 10;
    }

    // --------------------- OPCIONAL: LOGIN ---------------------
    @GET
    @Path("/login/{usuario}/{clave}")
    @Produces(MediaType.TEXT_PLAIN)
    public boolean login(@PathParam("usuario") String usuario, @PathParam("clave") String clave) {
        return "MONSTER".equals(usuario) && "monster9".equals(clave);
    }

    // --------------------- MÉTODOS DEFAULT (NO USAR) ---------------------
    @GET
    @Produces(MediaType.TEXT_HTML)
    public String getHtml() {
        return "<h2>Servicio de Conversiones Activo ✅</h2>"
                + "<p>Prueba una ruta, por ejemplo:</p>"
                + "<ul>"
                + "<li>/conversion/pulgadas-a-cm/10</li>"
                + "<li>/conversion/celsius-a-fahrenheit/25</li>"
                + "<li>/conversion/kg-a-gramos/5</li>"
                + "</ul>";
    }

    @PUT
    @Consumes(MediaType.TEXT_HTML)
    public void putHtml(String content) {
    }
}
