package net.kube.land.admin;

import de.codecentric.boot.admin.server.config.EnableAdminServer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.EnableScheduling;

import javax.annotation.PreDestroy;

@EnableAdminServer
@EnableDiscoveryClient
@SpringBootApplication
@EnableScheduling
public class AdminApplication {

    @Autowired
    private Environment environment;

    private static final Logger LOGGER = LoggerFactory.getLogger(AdminApplication.class);

    public static void main(String[] args) {

        LOGGER.info("Spring.Profiles.Active :-> " + System.getProperty("spring.profiles.active"));

        SpringApplication.run(AdminApplication.class, args);

        LOGGER.info("Started ADMIN Console/Catalog...");
    }

    @PreDestroy
    public void onDestroy() {

        LOGGER.info("DESTROYING :::>>> " + environment.getProperty("spring.application.name") + " ::: Spring.Profiles.Active :-> " +environment.getProperty("spring.profiles.active"));

        LOGGER.info("DESTROYED :::>>> " + environment.getProperty("spring.application.name") + " ::: Spring.Profiles.Active :-> " + environment.getProperty("spring.profiles.active"));
    }
}

