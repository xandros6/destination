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

					<#if attribute.name == 'denominazione_' + request.ENV.LOCALE>
						<th>${["Name","Denominazione","Denominazione","Benennung"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                                                                                        
					<#if attribute.name == 'descrizione_uso_' + request.ENV.LOCALE>
						<th>${["Use Description","Descrizione Uso","Descrizione Uso","Nutzungsbeschreibung"][locale]}</th><td>${attribute.value}</td> 
                    </#if>	
					<#if attribute.name == 'fonte_iscritti_' + request.ENV.LOCALE>
						<th>${["Students number source (Estimated / calculated)", "Fonte Iscritti", "Source du nombre d'élèves inscrits (Estimé/calculé)", " Quelle der Inskribiertenzahlen (geschätzt/erhoben)"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
					<#if attribute.name == 'iscritti'>
						<th>${["Students number", "N. Iscritti", "Nombre d'élèves inscrits", "Anzahl der Inskribierten "][locale]}</th><td>${attribute.value}</td> 
                    </#if>	
					<#if attribute.name == 'fonte_addetti_scuole_' + request.ENV.LOCALE>
						<th>${["Employees number source (Estimated / calculated)", "Fonte Addetti", "Source du nombre d'employés (Estimé/calculé)", "Quelle der Beschäftigtenzahlen (geschätzt/erhoben)"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
					<#if attribute.name == 'addetti'>
						<th>${["Employees number", "N. Addetti", "Nombre d'employés", "Anzahl der Beschäftigten"][locale]}</th><td>${attribute.value}</td> 
                    </#if>			
					<#if attribute.name == 'partner_' + request.ENV.LOCALE>
						<th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
                </tr>
        </#if>
    </#list>
	<th>${["Type","Tipologia","Tipologia","Tipologia"][locale]}</th><td>${["Scholastic Structures Users/Employees","Iscritti/Addetti strutture scolastiche","Iscritti/Addetti strutture scolastiche","Iscritti/Addetti strutture scolastiche"][locale]}</td> 
    </tr>

</table>
<hr />
</#list>
<br/>
