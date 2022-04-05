package com.demo.rest;

import static org.junit.Assert.assertEquals;


import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.core.Response;

import org.apache.cxf.jaxrs.provider.jsrjsonp.JsrJsonpProvider;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class HelloIT {

    private Client client;
    private Response response;

    @Before
    public void setup() {
        response = null;
        client = ClientBuilder.newClient();
        client.register(JsrJsonpProvider.class);
    }

    @After
    public void teardown() {
        response.close();
        client.close();
    }

    @Test
    public void HelloTest() throws Exception {
        response = client.target("http://localhost:9080/dev-demo/api/hello").request().get();
        String actual = response.readEntity(String.class);
        assertEquals("hello", actual);
    }
    
}
