{{ partial('partials/header') }}
		<section class="light">
			<div class="container">
				<div class="row py-3">
					<div class="col-12 col-md-8">
						<span>{{ file.categorie_es }}</span>
						<h2>{{ file.title }}</h2>
						<h3>{{ file.titulo_en }}</h3>
						<p><i>{% for autor in file.autores %}{% if autor['collab'] is empty %}{% if not loop.first %}, {% endif %}{{ autor['nombres'] }} {{ autor['apellidos'] }}{%if autor['email'] %} <sup><i class="far fa-envelope"></i></sup>{% endif %}{% endif %}{% endfor %}{% for collab in file.collab %}, {{ collab['name'] }}{% endfor %}</i></p>
						<p><span>{% if file.fechapublicacion %}Publicado el {{dateformat('%e de %B de %G', file.fechapublicacion)}}{% endif %}{% if file.doi %}  |  <span class="d-sm-none">http://doi.org/</span>{{ file.doi }}{% endif %}</span></p>
					</div>
					<div class="col-12 col-md-4">
						<div class="acciones row">
							<div class="col">
								<p>compartir</p>
								<ul class="pl-0">
									<li><a href=""><i class="fab fa-facebook-f"></i></a></li>
									<li><a href=""><i class="fab fa-twitter"></i></a></li>
									<li><a href=""><i class="far fa-envelope"></i></a></li>
								</ul>
							</div>
							<div class="col">
								<p>archivo</p>
								<ul class="pl-0 d-flex">
									<li>{% if request.get('lang') == 'en' %}<a href="?lang=">ES</a>{% else %}<a href="?lang=en">EN</a>{% endif %}</li>
									{% if file.pdf %}<li class="align-self-end"><a href="{{ file.pdf_es }}"><i class="fas fa-file-download"></i></a></li>{% endif %}
									<li><a href=""><i class="fas fa-print"></i></a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="container_fluid">
				<div class="row dark">
					<div class="col-12">
						<div class="container">
							<ul class="nav menu-articulo py-1" role="tablist">
								<li class="nav-item">
									<a class="nav-link active" id="article-tab" data-bs-toggle="tab" data-bs-target="#article-tab-pane">Artículo</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" id="autors-tab" href="#" data-bs-toggle="tab" data-bs-target="#autors-tab-pane">Autores</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" id="history-tab" href="#" data-bs-toggle="tab" data-bs-target="#history-tab-pane">Historial</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="container tab-content">
				<div class="tab-pane show active" id="article-tab-pane">
					<div class="row">
						<div class="col-12 col-md-8">
							<article class="py-5 pr-md-4">

{% if request.get('lang') == 'en' %}
	{% if file.contenido_en %}
		<a name="abstract"></a>
		{% if file.resumen_en|length or file.estructura_en|length %}
		<section id="index_0">
			<h1>Abstract</h1>
		{% endif %}
		<p>{{ file.resumen_en|nl2br }}</p>
		{% for estructura in file.estructura_en %}
		<p><b>{{estructura['titulo']}}</b> {{estructura['texto']}}</p>
		{% endfor%}
		</section>
		{% set indice = 0 %}

		{% if file.ideasclaves_en is defined %}{% set indice += 1 %}
		<a name="index_0"></a>
		<section id="index_{{ indice }}">
		<div class="ideasclave">
			<p><b>Main messages</b></p>
			<ul>
				{% for idea in file.ideasclaves_en %}
				<li>{{ idea['texto'] }}</li>
				{% endfor %}
			</ul>
		</div>
		</section>
		{% endif %}

		{% set contenido = file.contenido_en %}
		{# note: replace figures in content #}
		{% for figura in file.figuras_en %}
			{% set html = '<a name="' ~ figura['id'] ~ '"></a><figure><label>' ~ figura['label'] ~ '</label><div class="caption">' ~ figura['caption'] ~ '</div><img src="' ~ figura['image'] ~ '"><div class="notes">' ~ figura['notes'] ~ '</div><a class="fullsize" href="' ~ file.url ~ '?tpl=figure&id=' ~ figura['id'] ~ '">Full size <i class="fas fa-expand-arrows-alt"></i></a></figure>' %}
			{% set contenido = replace('<p>[#' ~ figura['id'] ~ ']</p>', html, contenido) %}
			{% set contenido = replace('[#' ~ figura['id'] ~ ']', html, contenido) %}
		{% endfor %}
		{# note: replace tables in content #}
		{% for tabla in file.tablas_en %}
			{% set html = '<a name="' ~ tabla['id'] ~ '"></a><figure><label>' ~ tabla['label'] ~ '</label><div class="caption">' ~ tabla['caption'] ~ '</div><a class="fullsize" href="' ~ file.url ~ '?tpl=table&id=' ~ tabla['id'] ~ '">View table <i class="fas fa-expand-arrows-alt"></i></a></figure>' %}
			{% set contenido = replace('<p>[#' ~ tabla['id'] ~ ']</p>', html, contenido) %}
			{% set contenido = replace('[#' ~ tabla['id'] ~ ']', html, contenido) %}
		{% endfor %}
		{# note: replace boxed in content #}
		{% for caja in file.cajas_en %}
			{% set html = '<a name="' ~ caja['id'] ~ '"></a><boxed-text><label>' ~ caja['label'] ~ '</label><caption>' ~ caja['caption'] ~ '</caption>' ~ caja['contenido'] ~ '</boxed-text>' %}
			{% set contenido = replace('<p>[#' ~ caja['id'] ~ ']</p>', html, contenido) %}
			{% set contenido = replace('[#' ~ caja['id'] ~ ']', html, contenido) %}
		{% endfor %}
		{# note: split h1 tags for index #}
		{% set pos = strpos(contenido, '<h1') %}
		{% if pos === false %}
			{{ contenido|medwave_reference }}
		{% else %}
			{% if pos > 0 %}
				{{ substr(contenido, 0, pos - 1) }}
				{% set partes = substr(contenido, pos)|split('<h1') %}
			{% else %}
				{% set partes = contenido|split('<h1') %}
			{% endif %}
			{% if partes|length %}
				{% for parte in partes %}{% if parte|length %}{% set indice += 1 %}
					<a name="index_{{ indice }}"></a><section id="index_{{ indice }}"><h1{{ parte|medwave_reference }}</section>
				{% endif %}{% endfor %}
			{% else %}
				{{ contenido|medwave_reference }}
			{% endif %}
		{% endif %}
	{% else %}
	<p><a href="{{ file.url }}">Only available in Spanish.</a></p>
	{% endif %}
{% else %}
	{% if file.contenido_es %}
		<a name="abstract"></a>
		{% if file.resumen_es|length or file.estructura_es|length %}
		<section id="index_0">
			<h1>Resumen</h1>
		{% endif %}
		<p>{{ file.resumen_es|nl2br }}</p>
		{% for estructura in file.estructura_es %}
		<p><b>{{estructura['titulo']}}</b> {{estructura['texto']}}</p>
		{% endfor%}
		</section>
		{% set indice = 0 %}

		{% if file.ideasclaves_es is defined %}{% set indice += 1 %}
		<a name="index_0"></a>
		<section id="index_{{ indice }}">
		<div class="ideasclave">
			<p><b>Ideas clave</b></p>
			<ul>
				{% for idea in file.ideasclaves_es %}
				<li>{{ idea['texto'] }}</li>
				{% endfor %}
			</ul>
		</div>
		</section>
		{% endif %}
		<div>
		{% set contenido = file.contenido_es %}
		{# note: replace figures in content #}
		{% for figura in file.figuras %}
			{% set html = '<a name="' ~ figura['id'] ~ '"></a><figure><label>' ~ figura['label'] ~ '</label><div class="caption">' ~ figura['caption'] ~ '</div><img src="' ~ figura['image'] ~ '"><div class="notes">' ~ figura['notes'] ~ '</div><a class="fullsize" href="' ~ file.url ~ '?tpl=figure&id=' ~ figura['id'] ~ '">Tamaño completo <i class="fas fa-expand-arrows-alt"></i></a></figure>' %}
			{% set contenido = replace('<p>[#' ~ figura['id'] ~ ']</p>', html, contenido) %}
			{% set contenido = replace('[#' ~ figura['id'] ~ ']', html, contenido) %}
		{% endfor %}
		{# note: replace tables in content #}
		{% for tabla in file.tablas %}
			{% set html = '<a name="' ~ tabla['id'] ~ '"></a><figure><label>' ~ tabla['label'] ~ '</label><div class="caption">' ~ tabla['caption'] ~ '</div><a class="fullsize" href="' ~ file.url ~ '?tpl=table&id=' ~ tabla['id'] ~ '">Ver tabla <i class="fas fa-expand-arrows-alt"></i></a></figure>' %}
			{% set contenido = replace('<p>[#' ~ tabla['id'] ~ ']</p>', html, contenido) %}
			{% set contenido = replace('[#' ~ tabla['id'] ~ ']', html, contenido) %}
		{% endfor %}
		{# note: replace boxed in content #}
		{% for caja in file.cajas %}
			{% set html = '<a name="' ~ caja['id'] ~ '"></a><boxed-text><label>' ~ caja['label'] ~ '</label><caption>' ~ caja['caption'] ~ '</caption>' ~ caja['contenido'] ~ '</boxed-text>' %}
			{% set contenido = replace('<p>[#' ~ caja['id'] ~ ']</p>', html, contenido) %}
			{% set contenido = replace('[#' ~ caja['id'] ~ ']', html, contenido) %}
		{% endfor %}
		{# note: split h1 tags for index #}
		{% set pos = strpos(contenido, '<h1') %}
		{% if pos === false %}
			{{ contenido|medwave_reference }}
		{% else %}
			{%if pos > 0 %}
				{{ substr(contenido, 0, pos - 1) }}
				{% set partes = substr(contenido, pos)|split('<h1') %}
			{% else %}
				{% set partes = contenido|split('<h1') %}
			{% endif %}
			{% if partes|length %}
				{% for parte in partes %}{% if parte|length %}{% set indice += 1 %}
					<a name="index_{{ indice }}"></a><section id="index_{{ indice }}"><h1{{ parte|medwave_reference }}</section>
				{% endif %}{% endfor %}
			{% else %}
				{{ contenido|medwave_reference }}
			{% endif %}
		{% endif %}
	{% else %}
	<p><a class="btn btn-primary" href="{{ file.url }}?lang=en">Sólo disponible en inglés.</a></p>
	{% endif %}
{% endif %}

							</article>
						</div>
						<div class="d-none d-md-block col-4">
							<sidebar>
								<nav class="py-5">
									{% if request.get('lang') == 'en' %}
									<ul class="pl-0">
										<li class="my-2"><a href="#index_0" class="active">Abstract</a></li>
										{% set titulos = file.contenido_en|tagsname('h1') %}
										{% if file.ideasclaves_es is defined %}{% set indice += 1 %}<li><a href="#index_1">Keys Ideas</a></li>{% endif %}
										{% for titulo in titulos %}
										<li class="my-2"><a href="#index_{{ loop.index + indice }}">{{titulo}}</a>
										{% endfor %}
									</ul>
									{% else %}
									<ul class="pl-0">
										<li class="my-2"><a href="#index_0" class="active">Resumen</a></li>
										{% set titulos = file.contenido_es|tagsname('h1') %}
										{% if file.ideasclaves_es is defined %}{% set indice += 1 %}<li><a href="#index_1">Ideas clave</a></li>{% endif %}
										{% for titulo in titulos %}
										<li class="my-2"><a href="#index_{{ loop.index + indice }}">{{titulo}}</a>
										{% endfor %}
									</ul>
									{% endif %}
								</nav>
							</sidebar>
						</div>
					</div><!-- .row -->
				</div><!-- #article-tab-pane -->
				<div class="tab-pane" id="autors-tab-pane">
					<div class="row">
						<div class="col-12">
							<div id="autors" class="py-5">
								<h1>Acerca de los autores</h1>
						
{% for autor in file.autores %}{% if autor['collab'] is empty %}
<h5>{{ autor['nombres'] }} {{ autor['apellidos'] }}</h5>
	{% set filiaciones = autor['filiacion']|split(';') %}
	{% for filiacion in filiaciones %}
		{%if loop.first %}<p>{% endif %}
			<i class="fas fa-link"></i> {{ filiacion|trim }}
		{% if loop.last %}</p>{% else %}<br>{% endif %}
	{% endfor %}
	{%if autor['email']%}
	<p><a href="mailto:{{ autor['email'] }}"><i class="far fa-envelope"></i> {{ autor['email'] }}</a></p>
	{% endif %}
	{%if autor['twitter'] %}
	<p><a href="https://twitter.com/{{ autor['twitter'] }}" target="_blank" title="Twitter Account"><i class="fab fa-twitter"></i> @{{ autor['twitter'] }}</a></p>
	{% endif %}
	{% if autor['correspondencia'] %}
	<p><i class="fas fa-map-marker-alt"></i> {{ autor['correspondencia'] }}</p>
	{% endif %}
	{% if autor['orcid'] %}
	<p class="orcid mb-1" id="authOrcid-0">
		<a id="connect-orcid-link" href="https://orcid.org/{{ autor['orcid'] }}" target="_blank" title="ORCID Registry">
			<i class="fab fa-orcid oc-txt" style="font-size:13px;"></i>
			https://orcid.org/{{ autor['orcid'] }}
		</a>
	</p>
	{% endif %}
{% endif %}{% endfor %}
{% for collab in file.collab %}
<h4>{{ collab['name'] }}</h4>
{% for autor in file.autores %}{% if autor['collab'] == collab['num'] %}
<h5>{{ autor['nombres'] }} {{ autor['apellidos'] }}</h5>
	{% set filiaciones = autor['filiacion']|split(';') %}
	{% for filiacion in filiaciones %}
		{%if loop.first %}<p>{% endif %}
			<i class="fas fa-link"></i> {{ filiacion|trim }}
		{% if loop.last %}</p>{% else %}<br>{% endif %}
	{% endfor %}
	{%if autor['email']%}
	<p><a href="mailto:{{ autor['email'] }}"><i class="far fa-envelope"></i> {{ autor['email'] }}</a></p>
	{% endif %}
	{%if autor['twitter'] %}
	<p><a href="https://twitter.com/{{ autor['twitter'] }}" target="_blank" title="Twitter Account"><i class="fab fa-twitter"></i> @{{ autor['twitter'] }}</a></p>
	{% endif %}
	{% if autor['correspondencia'] %}
	<p><i class="fas fa-map-marker-alt"></i> {{ autor['correspondencia'] }}</p>
	{% endif %}
	{% if autor['orcid'] %}
	<p class="orcid mb-1" id="authOrcid-0">
		<a id="connect-orcid-link" href="https://orcid.org/{{ autor['orcid'] }}" target="_blank" title="ORCID Registry">
			<i class="fab fa-orcid oc-txt" style="font-size:13px;"></i>
			https://orcid.org/{{ autor['orcid'] }}
		</a>
	</p>
	{% endif %}
{% endif %}{% endfor %}
{% endfor %}
							</div><!-- #autors -->
						</div>
					</div>
				</div><!-- #autors-tab-panel -->
				<div class="tab-pane" id="history-tab-pane">
					<div class="row">
						<div class="col-12">
							<div id="autors" class="py-5">
								<h1>Historial</h1>
	<p class="mb-2"><strong>Citación</strong> {% for autor in file.autores %}{% if autor['collab'] is empty %}{% if loop.index0 == 6 %}et al{% break %}{% elseif not loop.first %}, {% endif %}{{ autor['apellidos'] }} {{ autor['iniciales'] }}{% endif %}{% endfor %}. {{file.titulo_en}}. <i>Medwave</i> {{ file.volume + 2000 }};{{ file.volume }}({{ file.issue }}):e{{ file.code }} doi: {{file.doi}}</p>
	<p class="mb-2"><strong>Envío</strong> {{dateformat('%d/%m/%Y', file.fechaenvio)}}</p>
	<p class="mb-2"><strong>Aceptación</strong> {{dateformat('%d/%m/%Y', file.fechaaceptacion)}}</p>
	<p class="mb-2"><strong>Publicación</strong> {{dateformat('%d/%m/%Y', file.fechapublicacion)}}</p>
	{% if file.nota_idioma_es %}
	<p class="mb-2"><strong>Idioma del envío</strong> {{ file.nota_idioma_es | nl2br}}</p>
	{% endif %}

	<p class="mb-2"><strong>Origen y arbitraje</strong> {{ file.nota_origen_es }}</p>
</div>

							</div>
						</div>
					</div>
				</div>
			</div><!-- .tab-content -->
		</section>
		<section class="destacados dark py-5">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<h2>Referencias</h2>
{% for referencia in file.referencias %}
{% if loop.first%}<ol>{% endif %}
	<li id="reference_{{ loop.index }}"><span>{{ referencia['texto'] }}</span>
		{%if referencia['doi']%} | <a href="http://doi.org/{{ referencia['doi'] }}" target="_blank">CrossRef</a> {% endif %}
		{%if referencia['pmid']%} | <a href="https://pubmed.ncbi.nlm.nih.gov/{{ referencia['pmid'] }}?dopt=Abstract" target="_blank">PubMed</a> {% endif %}
		{%if referencia['link']%} | <a href="{{ referencia['link'] }}" target="_blank">Link</a> {% endif %}
	</li>
{% if loop.last %}</ol>{% endif %}
{% else %}
<p>Artículo no tiene referencias.</p>
{% endfor %}
					</div>
				</div>
			</div>		
		</section>
{{ partial('partials/footer') }}