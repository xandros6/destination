<div id="main" class="links">
    <a href="http://84.33.2.23/MapStore" target="_blank"><img src="http://84.33.2.23/MapStore/theme/app/img/BannerDestination_ftl.jpg" width="230" height="83" Hspace="10" Vspace="5"/></a>
</div>

<#list features as feature>
<table class="featureInfo">
  <tr>

    <th class="title">Attribute</th><th class="title">Value</th>

  </tr>

<#assign odd = false>
    <#list feature.attributes as attribute>
        <#if !attribute.isGeometry>
         <#if odd>
         <tr class="odd">
         <#else>
                <tr>
                </#if>
                
                
                <#assign odd = !odd>
                			<#if attribute.name == 'distanza'>
                                <th>distanza</th><td>${attribute.value}</td> 
                            </#if>    
                			<#if attribute.name == 'codice'>
                                <th>codice</th><td>${attribute.value}</td> 
                            </#if>   
                			<#if attribute.name == 'tipologia'>
                                <th>tipologia</th><td>${attribute.value}</td> 
                            </#if>      
                            <#if attribute.name == 'calc_formula_tot'>
                                <th>totale</th><td>${attribute.value}</td> 
                            </#if>                               
                            <#if attribute.name == 'calc_formula_scuole'>
                                <th>scuole</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_formula_ospedali'>
                                <th>ospedali</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_formula_distrib'>
                                <th>distrib</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_formula_residenti'>
                                <th>residenti</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_formula_soc'>
                                <th>soc</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_formula_servizi'>
                                <th>servizi</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_formula_amb'>
                                <th>amb</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_formula_aree_protette'>
                                <th>aree protette</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_formula_turisti_medi'>
                                <th>turisti medi</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_formula_turisti_max'>
                                <th>calc_formula_turisti_max</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_formula_aree_agricole'>
                                <th>aree agricole</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_formula_aree_boscate'>
                                <th>aree boscate</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_formula_flusso'>
                                <th>flusso</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_formula_beni_culturali'>
                                <th>beni culturali</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_formula_acque_superf'>
                                <th>acque superficiali</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_formula_acque_sotterranee'>
                                <th>acque sotterranee</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_formula_zone_urbanizzate'>
                                <th>zone urbanizzate</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'nr_incidenti'>
                                <th>numero incidenti</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'pter'>
                                <th>pter</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'nr_incidenti_elab'>
                                <th>incidenti elab</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'calc_pis'>
                                <th>calc pis</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'nr_pers_flusso'>
                                <th>nr_pers_flusso</th><td>${attribute.value}</td> 
                            </#if>  
                            <#if attribute.name == 'lunghezza'>
                                <th>lunghezza</th><td>${attribute.value}</td> 
                            </#if>                              
                </tr>
        </#if>
    </#list>
    </tr>

</table>
<hr />
</#list>
<br/>
