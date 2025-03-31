package com.br.java.Appchuva.demo.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.br.java.Appchuva.demo.Clients.ClientHome;
import com.br.java.Appchuva.demo.Dtos.Saida.DtosSaidaHome;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;

@Slf4j
@RequestMapping("/home")
@RestController
@RequiredArgsConstructor
public class ControllerHome {

    private final ClientHome clientHome;

    @GetMapping
    public ResponseEntity<DtosSaidaHome> getMethodName() {
        log.info("entrou");
        
        // Passando os parâmetros para a consulta
        DtosSaidaHome response = clientHome.listarUsuarios("306cf91e", "Campinas,SP");

        return ResponseEntity.accepted().body(response);
    }
}
