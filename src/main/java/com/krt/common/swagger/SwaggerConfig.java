package com.krt.common.swagger;

import com.krt.common.constant.SysConstant;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: Swagger初始化
 * @date 2017年04月15日
 */
@EnableWebMvc
@EnableSwagger2
@Configuration
public class SwaggerConfig extends WebMvcConfigurationSupport {

    @Bean
    public Docket createApi() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .enable(Boolean.valueOf(SysConstant.getValue("swagger.enable")))
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.krt.api.controller"))
                .paths(PathSelectors.any())
                .build()
                .useDefaultResponseMessages(false);
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("XXXXXX平台API")
                .termsOfServiceUrl("http://www.cnkrt.com/")
                .contact(new Contact("殷帅","http://www.cnkrt.com/","279467439@qq.com"))
                .version("1.0.1")
                .build();
    }

}