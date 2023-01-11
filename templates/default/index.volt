{{ partial('partials/header') }}
{% set current_issue = getfileX('/ediciones/', ['sort': 'id', 'asc': false]) %}
<article id="titular" class="dark mt-5">
	<div class="container">
		<div class="row py-4 px-5">
			<div class="col-12">
				<div class="row destacado">
					{% if current_issue.image_es %}
					<div class="col-12 col-md-6">
						<img src="{{ current_issue.image_es }}">
					</div>
					{% endif %}
					<div class="col-12 col-md-6">
						<span>Última edición</span>
						<h3>{{ current_issue.title }}</h3>
						<p>{{ current_issue.summary_es }}</p>
						<a href="{{ current_issue.url }}" class="btn btn-primary">Ver la edición</a>
					</div>						
				</div>
			</div>
		</div>
	</div>		
</article>
		<section class="destacados dark py-5">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<h2>Últimos artículos</h2>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<div class="row">
							{% set articles_lasts = filesX(3, ['sort': 'id', 'asc': false, 'limit': 4]) %}
							{% for article in articles_lasts %}
							<div class="col-12 col-md-6 col-lg-3 p-3">
								<div class="caja-destacado-grande">
									{% if articulo.imagen %}
										<a href="{{ article.url }}"><img src="{{ article.imagen }}"></a>
									{% else %}
										<a href="{{ article.url }}"><img src="/skins/default/images/OJ-image.png"></a>
									{% endif %}
									<div class="p-3">
										<span>{{ article.categorie_es }}</span>
										<h3><a href="{{ article.url }}">{{ article.title }}</a></h3>
										<p>{% for autor in article.autores %}{% if autor['collab'] is empty %}{% if loop.first %}{{ autor['nombres'] }} {{ autor['apellidos'] }}, et al.{% endif %}{% endif %}{% endfor %} ({{dateformat('%d/%m/%Y', article.fechapublicacion)}})</p>
									</div>
								</div>
							</div>
							{% endfor %}
						</div>
						<!-- div class="acciones row pt-3">
							<div class="col-12 text-center">
								<button type="button" class="btn btn-primary">Ver más <i class="fas fa-arrow-right ml-1"></i></button>
							</div>
						</div -->
					</div>
				</div>
			</div>		
		</section>
		<section class="light py-5">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<h2>Artículos más leídos</h2>
					</div>
				</div>
{% set articles = filter('', 'type', '=', 3) %}
{% set articles_mostreads = sql_getresults("select O.Id, count(*) from Objects O inner join Filters_Objects F_O on F_O.Objects_Id = O.Id inner join ObjectsLogs OL on OL.Objects_Id = O.Id where F_O.Filters_Id = :filter and OL.Date > DATE_SUB(NOW(),INTERVAL 1 YEAR) and O.Deleted = 'no' and O.Published = 'yes' group by O.Id order by count(*) desc limit 4", ['filter': articles.id]) %}
				<div class="row pt-3">
					<div class="col-12 col-md-8">
						<div class="row">
							{% for article_mostread in articles_mostreads %}{%set article = getobjectX(article_mostread['Id']) %}
							<div class="col-12 col-lg-6">
								<div class="caja-destacado-chica pb-3 mb-4">
									{% if articulo.imagen %}
										<a href="{{ article.url }}"><img src="{{ article.imagen }}"></a>
									{% else %}
										<a href="{{ article.url }}"><img src="/skins/default/images/OJ-image.png"></a>
									{% endif %}
									<span>{{ article.categorie_es }}</span>
									<h3><a href="{{ article.url }}">{{ article.title }}</a></h3>
								</div>
							</div>
							{% endfor %}
						</div>
					</div>
				</div>
			</div>		
		</section>
		<section class="destacados dark py-5">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<h2>Colecciones</h2>
					</div>
				</div>
				<!-- div class="row">
					<div class="col-12">
						<div class="row">
							<div class="col-12 col-md-6 col-lg-3 p-3">
								<div class="caja-destacado-grande">
									<img src="https://app.vinglet.com/default-image.png">
									<div class="p-3">
										<span>Editorial</span>
										<h3>Use Bootstrap’s custom button styles for actions in forms</h3>
										<h4>Bootstrap includes several predefined button styles, each serving its own semantic purpose</h4>
										<p>thrown in for more control</p>
										<i>predefined button</i>
									</div>
								</div>
							</div>
							<div class="col-12 col-md-6 col-lg-3 p-3">
								<div class="caja-destacado-grande">
									<img src="https://app.vinglet.com/default-image.png">
									<div class="p-3">
										<span>Editorial</span>
										<h3>Use Bootstrap’s custom button styles for actions in forms</h3>
										<h4>Bootstrap includes several predefined button styles, each serving its own semantic purpose</h4>
										<p>thrown in for more control</p>
										<i>predefined button</i>
									</div>
								</div>
							</div>
							<div class="col-12 col-md-6 col-lg-3 p-3">
								<div class="caja-destacado-grande">
									<img src="https://app.vinglet.com/default-image.png">
									<div class="p-3">
										<span>Editorial</span>
										<h3>Use Bootstrap’s custom button styles for actions in forms</h3>
										<h4>Bootstrap includes several predefined button styles, each serving its own semantic purpose</h4>
										<p>thrown in for more control</p>
										<i>predefined button</i>
									</div>
								</div>
							</div>
							<div class="col-12 col-md-6 col-lg-3 p-3">
								<div class="caja-destacado-grande">
									<img src="https://app.vinglet.com/default-image.png">
									<div class="p-3">
										<span>Editorial</span>
										<h3>Use Bootstrap’ custom button styles for actions in forms</h3>
										<h4>Bootstrap includes several predefined button styles, each serving its own semantic purpose</h4>
										<p>thrown in for more control</p>
										<i>predefined button</i>
									</div>
								</div>
							</div>
						</div>
						<div class="acciones row pt-3">
							<div class="col-12 text-center">
								<button type="button" class="btn btn-primary">Ver más <i class="fas fa-arrow-right ml-1"></i></button>
							</div>
						</div>
					</div>
				</div -->
			</div>		
		</section>
{{ partial('partials/footer') }}