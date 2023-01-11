<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>{{ web.title }}</title>
		<!-- Behavioral Meta Data -->
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<!-- iconos -->

		<!-- css -->
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.13.0/css/all.css">
		<!-- link rel="stylesheet" type="text/css" href="/skins/default/bootstrap5/css/bootstrap.min.css" / -->
		<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" />
		<link rel="stylesheet/less" type="text/css" href="/skins/default/css/screen.less"/>
		<link rel="stylesheet/less" type="text/css" href="/skins/default/css/openjournal.less"/>
		<!-- js -->
		<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js" integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk" crossorigin="anonymous"></script>
		<!-- script src="/skins/default/bootstrap5/js/bootstrap.bundle.min.js"></script -->
		<script src="/skins/default/js/less.js" ></script>
	    <!-- menú responsivo -->
	    <script type="text/javascript">
	        // $(function () {
	        //     $('.handler').on('click', function() {
	        //         $('.hamburger-menu').toggleClass('animate');
	        //     })
	        // })();
	    </script>	
	</head>
	<body>
		<header class="bg-dark">
			<nav class="navbar navbar-expand-xl navbar-dark p-0">
				<div class="container">
					<a class="navbar-brand" href="{{ web.url }}"></a>
					<div class="handler navbar-toggler mr-3" data-toggle="collapse" data-target="#navbarSupportedContentXL" aria-controls="navbarSupportedContentXL" aria-expanded="false" aria-label="Toggle navigation"><div class="hamburger-menu"></div>
					</div>
					<div class="collapse navbar-collapse" id="navbarSupportedContentXL">
						<ul id="menu-principal" class="navbar-nav ms-auto">
							<li class="nav-item active">
								<a class="nav-link" href="{{ web.url }}">Inicio <span class="sr-only">(current)</span></a>
							</li>
							<li class="nav-item hover dropdown">
								<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownXL" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Ediciones</a>
								<div class="dropdown-menu shadow-sm" aria-labelledby="navbarDropdownXL">
									<a class="dropdown-item" href="#">A</a>
									<a class="dropdown-item" href="#">B</a>
								</div>
							</li>
							<li class="nav-item hover dropdown">
								<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownXL" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Nosotros</a>
								<div class="dropdown-menu shadow-sm" aria-labelledby="navbarDropdownXL">
									<a class="dropdown-item" href="/about.html">Información de la revista</a>
									<a class="dropdown-item" href="/editors.html">Editores</a>
									<a class="dropdown-item" href="/editorial-board.html">Comité editorial</a>
								</div>
							</li>
						</ul>
						<ul id="menu-usuario" class="navbar-nav mr-3">
							<li class="nav-item">
								<button type="button" class="btn btn-primary btn-rounded my-tooltip" data-placement="bottom" title="Buscar"><i class="fas fa-search"></i></button>
							</li>
							<li class="nav-item">
								<button type="button" class="btn btn-primary my-tooltip" data-placement="bottom" data-toggle="dropdown" title="Usuario"><i class="fas fa-user"></i></button>
								<div class="dropdown-menu dropdown-menu-right dropdown-secondary shadow-sm" aria-labelledby="navbarDropdownMenuLink-55">
									<a class="dropdown-item" href="#">Preferencias</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="#">Cerrar Sesión</a>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</nav>
		</header><!-- fin header -->	