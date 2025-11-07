package ec.edu.monster.ws.filter;

import jakarta.ws.rs.container.ContainerRequestContext;
import jakarta.ws.rs.container.ContainerResponseContext;
import jakarta.ws.rs.container.ContainerResponseFilter;
import jakarta.ws.rs.ext.Provider;
import java.io.IOException;

/**
 * Filtro CORS para permitir peticiones desde el cliente web
 * 
 * @author Monster University
 */
@Provider
public class CorsFilter implements ContainerResponseFilter {

    @Override
    public void filter(ContainerRequestContext requestContext, 
                      ContainerResponseContext responseContext) throws IOException {
        
        // Permitir cualquier origen (para desarrollo)
        responseContext.getHeaders().add("Access-Control-Allow-Origin", "*");
        
        // Permitir credenciales
        responseContext.getHeaders().add("Access-Control-Allow-Credentials", "true");
        
        // Permitir estos métodos HTTP
        responseContext.getHeaders().add("Access-Control-Allow-Methods", 
            "GET, POST, PUT, DELETE, OPTIONS, HEAD");
        
        // Permitir estos headers
        responseContext.getHeaders().add("Access-Control-Allow-Headers", 
            "origin, content-type, accept, authorization");
        
        // Tiempo de cache para preflight
        responseContext.getHeaders().add("Access-Control-Max-Age", "1209600");
    }
}
