package com.br.java.Appchuva.demo.Clients;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.br.java.Appchuva.demo.Dtos.Saida.DtosSaidaHome;



@FeignClient(value = "ApiProduto", url = "https://api.hgbrasil.com/weather")
public interface ClientHome {

    // A URL do endpoint é definida aqui sem o '?' e os parâmetros
    @GetMapping
    DtosSaidaHome listarUsuarios(@RequestParam("key") String key, @RequestParam("city_name") String cityName);
}
