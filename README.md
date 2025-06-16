# Spring Security JDBC Authentication with H2 DB

This project demonstrates how to set up JDBC-based authentication in a Spring Boot application using Spring Security.

---

## ✅ Overview

In this project, we:

- Set up a Spring Boot application with JDBC authentication.
- Use an embedded H2 database.
- Use Spring Security’s default schema (`users`, `authorities`).
- Configure security to restrict access based on roles.

## 🧰 Prerequisites

- Java 11 or later
- Maven or Gradle
- IDE (IntelliJ / VSCode)
- Spring Boot CLI (optional)

## 🧩 Dependencies

Add these to your `pom.xml`:

```xml
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-security</artifactId>
</dependency>
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-jdbc</artifactId>
</dependency>
<dependency>
  <groupId>com.h2database</groupId>
  <artifactId>h2</artifactId>
  <scope>runtime</scope>
</dependency>
```

## Table Schema
```
create table users (
    username varchar_ignorecase(50) not null primary key,
    password varchar_ignorecase(500) not null,
    enabled boolean not null
);

create table authorities (
    username varchar_ignorecase(50) not null,
    authority varchar_ignorecase(50) not null,
    constraint fk_authorities_users foreign key(username) references users(username)
);

create unique index ix_auth_username on authorities (username, authority);
```
We will create a h2 database and create these above tables and add data statically.


##Spring Security Configuration

```
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

    @Autowired
    DataSource dataSource;

    //CONFIGURATION FOR AUTHENTICATION
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception{
        auth.jdbcAuthentication()
                .dataSource(dataSource)
                .usersByUsernameQuery(
                        "select username, password, enabled from users where username = ?"
                )
                .authoritiesByUsernameQuery(
                        "select username, authority from authorities where username = ?"
                );
        //CAN USE CUSTOMIZED TABLE BY CHANGING NAME OF THE TABLE FROM ABOVE QUERY
    }

    //CONFIGURATION FOR AUTHORIZATION
    @Override
    public void configure(HttpSecurity http) throws  Exception{
        http.authorizeRequests()
                .antMatchers("/admin").hasRole("ADMIN")
                .antMatchers("/user").hasAnyRole("USER","ADMIN")
                .antMatchers("/").permitAll()
                .and().formLogin();
    }


    @Bean
    public PasswordEncoder getPasswordEncoder(){
        return NoOpPasswordEncoder.getInstance();
    }
}
```
Using this configuration spring will allow some api to be accessed and restrict some according to your role stored in h2 DB









