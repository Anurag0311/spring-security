package com.example.spring_security_jwt.models;

public class AuthenticationResponse {

    private String jwt;

    public AuthenticationResponse(String jwt){
        this.jwt = jwt;
    }

    public AuthenticationResponse() {
        // Needed by Jackson
    }

    public String getJwt() {
        return jwt;
    }

    public String jwt(){
        return jwt;
    }

}
