<div id="main" class="links">
    <a href="http://destination.geo-solutions.it/MapStore" target="_blank"><img src="http://destination.geo-solutions.it/MapStore/theme/app/img/BannerDestination_ftl.jpg" width="230" height="83" Hspace="10" Vspace="5"/></a>
</div>

<#assign locale = {"en":0,"it":1,"fr":2,"de":3}[request.ENV.LOCALE]/>

<#list features as feature>
<table class="featureInfo">
  <tr>

    <th class="title">${["Attribute","Attribute","Attribute","Attribut"][locale]}</th><th class="title">${["Value","Value","Value","Wert"][locale]}</th>

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
					<#if attribute.name == 'residenti'>
						<th>${["Resident People","Residenti","Residenti","Anzahl der Anwohner"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
					<#if attribute.name == 'partner_' + request.ENV.LOCALE>
						<th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
                    <#if attribute.name == 'fonte_residenti_' + request.ENV.LOCALE>
						<th>${["Residents number source (Estimated / calculated)", "Fonte residenti", "Source du nombre de résidents (Estimé/calculé)", "Quelle der Anzahl der Anwohner (geschätzt/berechnet)"][locale]}</th><td>${attribute.value}</td> 
                    </#if>					
                </tr>
        </#if>
    </#list>
	<th>${["Type","Tipologia","Tipologia","Tipologia"][locale]}</th><td>${["Resident People","Popolazione residente","Popolazione residente","Popolazione residente"][locale]}</td> 
    </tr>

</table>
<hr />
</#list>
<br/>
