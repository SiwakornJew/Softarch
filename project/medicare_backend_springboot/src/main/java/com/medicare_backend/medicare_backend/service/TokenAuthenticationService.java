package com.medicare_backend.medicare_backend.service;

import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;

import io.jsonwebtoken.Jwts;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;

public class TokenAuthenticationService {

    @Value("${jwt_secret}")
    private static String secret = "secret";

    public static String generateJWTToken(String requestUser) throws NoSuchAlgorithmException {
        try {
            final Date createdDate = new Date();
            final Date expirationDate = new Date(createdDate.getTime() + 9000 * 1000);
            String jwtToken = JWT.create()
                    .withSubject("User Details")
                    .withClaim("authId", requestUser)
                    .withIssuedAt(new Date())
                    .withIssuer("codependa")
                    .withExpiresAt(expirationDate)
                    .sign(Algorithm.HMAC256(secret));
            return jwtToken;
        } catch (Exception e) {
            System.out.println(e);
            // Invalid Signing configuration / Couldn't convert Claims.
        }
        return "Error";
    }

    public static String verifyJWTToken(String tokenString) throws NoSuchAlgorithmException {
        try {
            JWTVerifier verifier = JWT.require(Algorithm.HMAC256(secret))
                    .withSubject("User Details")
                    .withIssuer("codependa")
                    .build();
            DecodedJWT jwt = verifier.verify(tokenString);
            return jwt.getClaim("authId").asString();
        } catch (Exception e) {
            System.out.println(e);
            // TODO: handle exception
            return "error";
        }
    }

}