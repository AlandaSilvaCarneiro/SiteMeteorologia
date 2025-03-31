    package com.br.java.Appchuva.demo.Dtos.Saida;

    import com.fasterxml.jackson.annotation.JsonProperty;
    import lombok.Data;

    @Data
    public class DtosSaidaHome {
        
        @JsonProperty("umidade")
        private Integer umidade;
        
        @JsonProperty("descricao")
        private String descricao;
        
        @JsonProperty("condition_slug")
        private String conditionSlug;
        
        @JsonProperty("city_name")
        private String cityName;
        
        @JsonProperty("velocidade_do_vento")
        private String velocidadeDoVento;
        
        @JsonProperty("sunrise")
        private String nascerDoSol;
        
    }

