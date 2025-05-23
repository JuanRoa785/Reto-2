create table tipousuario (
  id bigint primary key generated always as identity,
  nombre text not null,
  descripcion text not null
);

create table usuarios (
  id bigint primary key generated always as identity,
  correo text not null unique,
  contrasena text not null,
  nombre text not null,
  apellido text not null,
  telefono text,
  idtipousuario bigint not null,
  constraint fk_tipo_usuario foreign key (idtipousuario) references tipousuario (id)
);

create table carritos (
  id bigint primary key generated always as identity,
  idusuario bigint not null,
  total double precision not null,
  constraint fk_usuario foreign key (idusuario) references usuarios (id)
);

create table tipoproducto (
  id bigint primary key generated always as identity,
  nombre text not null,
  descripcion text not null
);

create table productos (
  id bigint primary key generated always as identity,
  idtipoproducto bigint not null,
  nombre text not null,
  descripcion text not null,
  imagen text,
  precio double precision not null,
  marca text,
  color text,
  modelo int,
  cantidad int not null,
  impuesto double precision not null,
  constraint fk_tipo_producto foreign key (idtipoproducto) references tipoproducto (id)
);

create table ventas (
  id bigint primary key generated always as identity,
  fecha timestamp with time zone not null,
  observaciones text,
  idusuario bigint not null,
  total double precision not null,
  direccion text NOT NULL,
  constraint fk_correo_usuario_venta foreign key (idusuario) references usuarios (id)
);

create table detalleventa (
  id bigint primary key generated always as identity,
  idproducto bigint not null,
  idventa bigint not null,
  cantidad int not null,
  constraint fk_producto_detalle foreign key (idproducto) references productos (id),
  constraint fk_venta foreign key (idventa) references ventas (id)
);

create table detallecarrito (
  id bigint primary key generated always as identity,
  idproducto bigint not null,
  idcarrito bigint not null,
  cantidad int not null,
  constraint fk_producto_detalle foreign key (idproducto) references productos (id),
  constraint fk_carrito foreign key (idcarrito) references carritos (id)
);

create table direccion (
  id bigint primary key generated always as identity,
  idusuario bigint not null,
  pais text not null,
  region text not null,
  ciudad text not null,
  direccion text not null,
  constraint fk_usuario foreign key (idusuario) references usuarios (id)
);

insert into tipousuario (nombre, descripcion)
values
('User', 'Aquellos clientes que solamente buscan comprar productos de la sucursal'),
('Admin', 'Aquellos Gerentes de la sucursal que necesitan acceder a los registros de ventas y el inventario');

insert into tipoproducto (nombre, descripcion)
values
('Consoles', 'Consolas de videojuegos'),
('Games', 'Videojuegos para diferentes consolas'),
('Controllers', 'Controles para diferentes consolas'),
('Accessories', 'Accesorios que necesita un gamer'),
('Recorders', 'Artefactos tecnologicos usados para grabar juegos'),
('TV''s & Monitors', 'Televisores y monitores de computador');

insert into productos (idtipoproducto, nombre, descripcion, imagen, precio, marca, color, modelo, cantidad, impuesto)
values
(1, 'PlayStation 5', 'Incluye controlador inalámbrico DualSense, SSD de 1 TB, cable HDMI, cable de alimentación de corriente alterna, cable USB, materiales impresos y sala de juegos de Astro (juego preinstalado).', 'https://i.imgur.com/Zgythev.jpg', 1999391, 'Sony', 'Blanco', 2020, 25, 0.15),
(1, 'Xbox Series X', '
Experimenta la Xbox Series X, la Xbox más rápida y potente que nunca. Explora nuevos y ricos mundos con 12 teraflops de potencia bruta de procesamiento gráfico, trazado de rayos DirectX, un SSD personalizado de 1 TB y juegos 4K.', 'https://i.imgur.com/12kwaxT.jpg', 1814524, 'Xbox', 'Negro', 2020, 30, 0.05),
(1, 'Steam Deck 512GB', 'Tu biblioteca de Steam, en cualquier lugar. Una vez que hayas iniciado sesión en Steam Deck, aparece toda tu biblioteca de Steam, al igual que cualquier otro PC. ', 'https://i.imgur.com/PElHdK1.jpg', 1676216, 'Valve', 'Negro', 2022, 51, 0.11),
(1, 'Nintendo Switch Oled', 'Pantalla LCD de 6.2 pulgadas con tres modos de reproducción para que juegues cooperativo local o multijugador inalambrico en línea y local.', 'https://i.imgur.com/rwpyJS5.jpg', 1086217, 'Nintendo', 'Negro', 2021, 51, 0.15),
(1, 'New Nintendo 3DS XL', 'La New Nintendo 3DS XL combina una pantalla 3D mejorada sin gafas, mayor potencia y controles adicionales para una experiencia de juego portátil envolvente.', 'https://i.imgur.com/1zMRK4M.jpg', 463208, 'Nintendo', 'Rojo', 2015, 52, 0.06),
(1, 'Xbox One S 500GB', 'La Xbox One S ofrece una experiencia de juego y entretenimiento en 4K Ultra HD con un diseño compacto y elegante. Disfruta de tus juegos favoritos, películas y series con HDR, además de almacenamiento amplio para tu colección digital', 'https://i.imgur.com/udcMS9w.jpg', 724820, 'Xbox', 'Blanco', 2016, 57, 0.11),
(1, 'PlayStation 4 Slim 1 TB', 'Disfruta de multiples juegos con un almacenamiento ampliado de una TB, junto con un diseño delgado que permite el facil traslado y multiples horas de juego con el mejor rendimiento posible.', 'https://i.imgur.com/KcEV7BS.jpg', 780044, 'Sony', 'Negro', 2013, 37, 0.14),
(1, 'PlayStation Vita', 'La PlayStation Vita es una consola portátil que combina gráficos de alta calidad con una experiencia de juego envolvente. Con su pantalla táctil OLED y controles intuitivos, ofrece una amplia biblioteca de juegos, desde aventuras épicas hasta títulos indie. ', 'https://i.imgur.com/05MsFvH.jpg', 705741, 'Sony', 'Negro', 2012, 51, 0.08),
(1, 'Nintendo DS XL', '
La Nintendo DS XL es la consola portátil ideal para los amantes de los juegos, con una pantalla más grande que ofrece una experiencia visual mejorada. Su diseño ligero y ergonómico permite horas de juego cómodo, mientras que su amplia biblioteca incluye clásicos y títulos innovadores.', 'https://i.imgur.com/bFc8kQX.jpg', 557149, 'Nintendo', 'Rojo', 2008, 70, 0.14),
(1, 'PlayStation Portable Go', 'La PlayStation Portable Go es una consola portátil compacta que redefine la forma de jugar sobre la marcha. Su diseño deslizante y pantalla brillante de 3.8 pulgadas te permiten disfrutar de tus juegos favoritos con comodidad y estilo.', 'https://i.imgur.com/jbIEpfm.jpg', 582706, 'Sony', 'Blanco', 2009, 48, 0.09),
(1, 'Xbox 360', 'La Xbox 360 es una consola de videojuegos que ofrece una experiencia de juego envolvente con gráficos impresionantes y un catálogo extenso de títulos, desde grandes éxitos hasta juegos indie.', 'https://i.imgur.com/dSG8H2P.jpg', 618319, 'Xbox', 'Negro', 2005, 36, 0.13),
(2, 'Demon''s Souls PS5', 'Un remake del clásico RPG de acción, donde los jugadores exploran el oscuro reino de Boletaria. Deben enfrentarse a aterradoras criaturas y poderosos jefes mientras buscan restaurar la luz y su propia alma.', 'https://i.imgur.com/KcwzOWs.jpg', 229486, 'Sony', 'No Aplica', 2020, 32, 0.07),
(2, 'Ratchet & Clank: Rift Apart PS5', 'Aventura intergaláctica donde Ratchet y Clank utilizan una nueva tecnología de dimensiones para viajar a través de mundos diversos. Deben detener al malvado Dr. Nefarious mientras descubren nuevos aliados y poderes.', 'https://i.imgur.com/oxqWtNF.jpg', 162545, 'Sony', 'No Aplica', 2021, 63, 0.12),
(2, 'Halo Infinite Xbox', 'El Jefe Maestro regresa para enfrentarse a una nueva amenaza en Zeta Halo. Con un enfoque en la exploración y la narrativa, los jugadores luchan contra enemigos mientras descubren los secretos de este mundo', 'https://i.imgur.com/zisCK8M.jpg', 98773, 'Xbox', 'No Aplica', 2021, 55, 0.1),
(2, 'Forza Horizon 5 Xbox', 'Un festival de carreras en un vasto y hermoso mundo abierto inspirado en México. Los jugadores participan en diversas competiciones y eventos, disfrutando de una impresionante selección de vehículos y personalización.', 'https://i.imgur.com/xuy8Alc.jpg', 122634, 'Xbox', 'No Aplica', 2021, 43, 0.12),
(2, 'Hades', 'Un rogue-like en el que Zagreus, el hijo de Hades, intenta escapar del inframundo. Con cada intento, los jugadores se enfrentan a enemigos y desbloquean nuevas habilidades gracias a la ayuda de dioses griegos.', 'https://i.imgur.com/HqXDpWl.jpg', 87830, 'Supergiant Games', 'No Aplica', 2020, 48, 0.06),
(2, 'Stardew Valley', 'Un simulador de granja donde los jugadores heredan una parcela en el campo. Cultivan, crían animales, hacen amistades en el pueblo y exploran minas en busca de tesoros y recursos.', 'https://i.imgur.com/LcafqTt.jpg', 45312, 'ConcernedApe', 'No Aplica', 2016, 32, 0.12),
(2, 'The Legend of Zelda: Breath of the Wild', 'Link despierta tras un largo sueño para descubrir Hyrule devastado. Con libertad total, explora un vasto mundo, resuelve acertijos y enfrenta enemigos para derrotar a Calamity Ganon y salvar a la princesa Zelda', 'https://i.imgur.com/wheSHb2.jpg', 161333, 'Nintendo', 'No Aplica', 2017, 38, 0.05),
(2, 'Super Mario Odyssey', 'Mario viaja por diversos mundos en su odisea para rescatar a Peach de Bowser. Utiliza su nuevo sombrero, Cappy, para tomar el control de otros personajes y objetos, resolviendo acertijos en su camino.', 'https://i.imgur.com/eCqXvQd.jpg', 169381, 'Nintendo', 'No Aplica', 2017, 31, 0.05),
(2, 'The Legend of Zelda: Ocarina of Time 3D', 'Link viaja a través del tiempo para detener al malvado Ganondorf. Con la ayuda de la Ocarina, explora Mazmorras, completa acertijos y reúne artefactos para salvar el reino de Hyrule.', 'https://i.imgur.com/DDKb9ln.jpg', 119318, 'Nintendo', 'No Aplica', 2011, 40, 0.1),
(2, 'Animal Crossing: New Leaf', 'Los jugadores se convierten en el alcalde de una isla encantadora, donde deben construir y personalizar su comunidad. Interactúan con adorables vecinos y participan en diversas actividades a lo largo de las estaciones.', 'https://i.imgur.com/qZUUWZl.jpg', 69813, 'Nintendo', 'No Aplica', 2012, 54, 0.07),
(2, 'Gears 5', 'En un mundo postapocalíptico, Kait Diaz busca respuestas sobre su legado y enfrenta nuevas amenazas. Los jugadores luchan en intensas batallas mientras exploran una narrativa rica y profunda.', 'https://i.imgur.com/BbDDAtV.jpg', 59906, 'Xbox', 'No Aplica', 2019, 44, 0.06),
(2, 'Sea of Thieves', 'Un juego multijugador de piratas donde los jugadores navegan, buscan tesoros y participan en batallas navales. La experiencia se centra en la cooperación, exploración y aventura en un mundo abierto.', 'https://i.imgur.com/IEUf1id.jpg', 90139, 'Xbox', 'No Aplica', 2018, 42, 0.08),
(2, 'The Last of Us Part II', 'Aventura postapocalíptica que sigue a Ellie en su búsqueda de venganza. La narrativa profunda y emocional explora temas de dolor, pérdida y la lucha por la supervivencia en un mundo devastado.', 'https://i.imgur.com/jjqN2Ns.jpg', 132277, 'Sony', 'No Aplica', 2020, 52, 0.12),
(2, 'God of War', 'Kratos, el dios de la guerra, y su hijo Atreus emprenden un viaje para esparcir las cenizas de su esposa. Enfrentan mitología nórdica y adversidades, mientras descubren su relación y enfrentan enemigos poderosos.', 'https://i.imgur.com/sftbuPB.jpg', 130561, 'Sony', 'No Aplica', 2018, 67, 0.07),
(2, 'Persona 4 Golden', 'Un RPG que sigue a un grupo de estudiantes mientras investigan misteriosos asesinatos en su pueblo. Utilizan la mecánica de "Personas" para combatir sombras en un mundo alternativo, todo mientras desarrollan relaciones personales.', 'https://i.imgur.com/nZ0eo3Z.jpg', 89312, 'Atlus', 'No Aplica', 2012, 66, 0.09),
(2, 'Uncharted: Golden Abyss', 'Precuela de la serie Uncharted, sigue a Nathan Drake en su búsqueda de un antiguo artefacto. Los jugadores exploran junglas y ruinas mientras resuelven acertijos y enfrentan enemigos.', 'https://i.imgur.com/cXF1Wbb.jpg', 64609, 'Sony', 'No Aplica', 2011, 48, 0.15),
(2, 'The Legend of Zelda: Phantom Hourglass', 'Link y Tetra navegan por el océano para rescatar a la princesa capturada. Utiliza la pantalla táctil para resolver acertijos y combatir enemigos en una aventura encantadora.', 'https://i.imgur.com/VVc2nUi.jpg', 87615, 'Nintendo', 'No Aplica', 2007, 60, 0.09),
(2, 'Pokémon HeartGold/SoulSilver', 'Remakes de los clásicos Pokémon Gold y Silver, donde los jugadores viajan por las regiones de Johto y Kanto. Capturan Pokémon, luchan en gimnasios y enfrentan a la Liga Pokémon mientras siguen la historia.', 'https://i.imgur.com/SHxC0vu.jpg', 98364, 'Nintendo', 'No Aplica', 2010, 43, 0.1),
(2, 'Metal Gear Solid: Peace Walker', 'Un juego de acción y sigilo que sigue a Big Boss en la década de 1970. Los jugadores deben construir un ejército, desarrollar tecnología y enfrentar una crisis nuclear en América Central', 'https://i.imgur.com/pTmQKaJ.jpg', 47455, 'Konami', 'No Aplica', 2010, 42, 0.12),
(2, 'Patapon', 'Un juego de ritmo donde los jugadores dirigen a adorables criaturas llamadas Patapon en su búsqueda de un dios. Usan ritmos de tambor para comandar acciones y enfrentar enemigos en niveles llenos de desafío.', 'https://i.imgur.com/moMnMkA.jpg', 49213, 'Sony', 'No Aplica', 2007, 46, 0.08),
(2, 'Halo 3', 'El Jefe Maestro debe detener a la Alianza y a los Flood mientras busca respuestas sobre su destino. La campaña culmina en una épica batalla por la supervivencia de la humanidad y el futuro del universo.', 'https://i.imgur.com/XUwcfgk.jpg', 51712, 'Microsoft', 'No Aplica', 2007, 44, 0.11),
(2, 'Gears of War', 'Un shooter en tercera persona donde los jugadores luchan contra las fuerzas Locust que amenazan a la humanidad. Con una intensa narrativa, el juego se centra en la camaradería y el combate táctico.', 'https://i.imgur.com/pi4bLLC.jpg', 60413, 'Microsoft', 'No Aplica', 2006, 64, 0.09),
(3, 'PS5 Dualsense Controller Galactic Purple', 'El controlador inalámbrico DualShock 4 ofrece una experiencia de juego precisa y envolvente con sus sticks analógicos duales, retroalimentación háptica, altavoz integrado y paradas de gatillo ajustables.', 'https://i.imgur.com/aybEbaF.jpg', 287477, 'Sony', 'Morado', 2020, 36, 0.09),
(3, 'Control Xbox Series X ', 'Controlador inalámbrico Microsoft Xbox para Xbox One, S/X y otras plataformas. Mantente en el objetivo con la almohadilla D híbrida, agarre texturizado en los gatillos y la carcasa trasera. Puerto USB tipo C.', 'https://i.imgur.com/C98wktV.jpg', 260000, 'Xbox', 'Negro', 2020, 33, 0.14),
(3, 'Nintendo Joy-Con (L/R) - Neon Pink / Neon Green', 'Los Joy-Con de Nintendo Switch ofrecen versatilidad para todo tipo de juego. Se pueden usar de forma separada en cada mano o juntos como un control tradicional. Además, pueden conectarse a la consola para un juego portátil o compartirse con amigos para experiencias multijugador.', 'https://i.imgur.com/bPccJbW.jpg', 313611, 'Nintendo', 'Neon Pink / Neon Green', 2021, 67, 0.08),
(3, 'Nintendo Switch Pro Controller', 'Lleva tus sesiones de juego a un nivel superior con el controlador Nintendo Switch Pro, el cual viene a un precio ideal junto con un cable de carga USB C para multiples horas de juego.', 'https://i.imgur.com/RWcfK3o.jpg', 255870, 'Nintendo', 'Negro', 2021, 33, 0.15),
(3, 'Mando Inalambrico Xbox One Edición Especial', 'El control inalámbrico para Xbox One ofrece conectividad Bluetooth para una experiencia sin cables. Destaca con su elegante diseño de camuflaje ártico y cuenta con 14 botones, incluidos botones de hombro y una almohadilla D para un control total. ', 'https://i.imgur.com/xHNX7Z3.jpg', 262723, 'Microsoft', 'Camuflaje Artico', 2014, 43, 0.12),
(3, 'PS4 Dualsense Controller Magma Red', 'El DualShock 4 ofrece un control mejorado con sticks analógicos y botones de disparo más sensibles, proporcionando una gran experiencia en cualquier juego. Su panel táctil multitáctil abre nuevas posibilidades, y cuenta con un altavoz integrado y un conector para auriculares. ', 'https://i.imgur.com/N7J38lX.jpg', 190721, 'Sony', 'Magma Red', 2014, 39, 0.11),
(3, '8Bitdo Ultimate Bluetooth Controller', 'Este control es compatible con Switch y Steam Deck a través de Bluetooth o USB, y con Windows mediante adaptador o cable. Ofrece una base de carga inteligente que enciende y apaga el controlador automáticamente.', 'https://i.imgur.com/J8NnZPo.jpg', 235231, '8bitdo', 'Negro', 2023, 54, 0.08),
(3, 'Voyee S08 Switch Bluetooth Controller', 'Este control destaca con modos de iluminación variados. Tiene una batería de 1000 mAh que ofrece hasta 15 horas de juego tras 3-4 horas de carga. Compatible con Switch/Lite/OLED, iOS, Android y PC.', 'https://i.imgur.com/9uohRcO.jpg', 86150, 'Voyee', 'Negro', 2021, 26, 0.13),
(4, 'Lapiz Tactil Para Nintendo 3ds XL', ' No dejes que un lápiz óptico perdido o dañado detenga tu juego, sigue jugando con el paquete de lápices ZedLabz para la nintendo 3DS XL.', 'https://i.imgur.com/hgzHBTO.jpg', 39906, 'ZedLabz', 'Negro', 2015, 54, 0.06),
(4, 'Estuche Protector Rigido Para 2 controles', 'Para controladores universales: este estuche de almacenamiento de controlador es compatible con controladores de juego de tamaño universal, como PS5, PS4, Xbox One, Switch Pro y más.', 'https://i.imgur.com/6GVlyca.jpg', 102850, 'Younik', 'Negro', 2020, 30, 0.07),
(4, 'Estuche Para 24 juegos de Nintendo Switch', 'Este estuche permite almacenar y organizar hasta 24 tarjetas de juego de Nintendo Switch, incluyendo espacio para tarjetas de memoria. Su diseño compacto facilita la inserción y extracción de los cartuchos.', 'https://i.imgur.com/ZeGxlr1.jpg', 19404, 'Amazon Basics', 'Negro', 2020, 50, 0.09),
(4, 'Cubiertas De Joystick Diseño Pokemon', 'Recibirás dos pares (4 unidades) de elegantes agarres Joycon para los pulgares, disponibles en dos colores y estilos diferentes. Estos accesorios añaden un toque de estilo y energía a tu experiencia de juego, son ligeros y delgados.', 'https://i.imgur.com/jGPTfuN.jpg', 38108, 'PerfectSight', 'No Aplica', 2021, 45, 0.11),
(4, 'Cubiertas De Silicona Para Controles', 'Estas tapas de agarre para el pulgar, fabricadas en silicona de alta calidad permiten un control preciso de los botones. Su diseño de calavera añade un toque de estilo y personalidad a tu consola. para instalarlo simplemente voltea la tapa y colócala en el joystick.', 'https://i.imgur.com/ZGzAtiE.jpg', 32238, 'Subang', 'No Aplica', 2018, 29, 0.05),
(4, 'Torre De Almacenamiento de Videojuegos', 'Di adiós al desorden: manten tus juegos organizados y fáciles de encontrar. Cada torre puede contener hasta 19 juegos. ¡No más búsquedas a través de montones de discos de juego! y nunca tendrás que preocuparte por perder tus juegos de nuevo con este soporte.', 'https://i.imgur.com/4PNbyYY.jpg', 95696, 'Allnice', 'Blanco', 2022, 25, 0.15),
(4, 'Gigastone Tarjeta Micro SD de 512 GB', 'Ofrece lectura y escritura de hasta 100/60 MB/s, permite la visualización y grabación de videos en Ultra HD. Diseñado especialmente para consolas, con la especificación A1 que garantiza transferencias de datos de alta velocidad.', 'https://i.imgur.com/6rm9ar9.jpg', 217523, 'Gigastone', 'Blanco', 2020, 27, 0.09),
(4, 'Tarjeta Micro SD de 256 GB SanDisk', 'Con una capacidad de hasta 256 GB, este almacenamiento masivo te permite guardar todos tus juegos favoritos. Ofrece velocidades de lectura de hasta 190 MB/s y escritura de 130 MB/s, lo que te ayuda a iniciar tus juegos rápidamente.', 'https://i.imgur.com/zpBi8W8.jpg', 118816, 'SanDisk', 'No Aplica', 2021, 30, 0.14),
(4, 'Volante de Switch para Mario Kart 8 Deluxe', 'Disfruta con este paquete de volantes para Nintendo Switch, perfecto como regalo o para ti mismo. Fabricados con materiales ABS duraderos y ecológicos, estos volantes ofrecen una experiencia de conducción auténtica.', 'https://i.imgur.com/FaGOR7l.jpg', 52381, 'Purbhe', 'Negro', 2022, 47, 0.05),
(4, 'Auriculares Inalámbricos Para Videojuegos Tatybo', 'Disfruta de un sonido envolvente 7.1 PRO con estos auriculares inalámbricos para multiples plataformas, que cuentan con un micrófono que mejora la claridad de las voces y resalta detalles como pasos y disparos lejanos.', 'https://i.imgur.com/nne3vMX.jpg', 121478, 'Tatybo', 'Negro', 2020, 33, 0.15),
(5, 'Game Capture HD60 X', 'HD60 X captura tus partidas de PS5 o Xbox de forma profesional. Haz streaming o graba contenido de alta resolución para públicos de cualquier plataforma. Sin suscripciones. Sin limitaciones.', 'https://i.imgur.com/bxmWjC1.png', 799815, 'Elgato', 'Negro', 2022, 42, 0.08),
(5, 'Tarjeta De Captura Interna 4K60 Pro MK.2', 'Captura con ultra calidad en 4K60 HDR10 y disfruta de un paso a través sin latencia. Con Instant Gameview y paso a través de 240 Hz, optimiza tu flujo de trabajo y disfruta de tu configuración sin compromisos. ', 'https://i.imgur.com/Ov7ETMv.jpg', 920522, 'Elgato', 'Negro', 2019, 37, 0.15),
(5, 'Elgato HD60 S+', 'Captura HDR10 de 1080p y 60 fps; Comparte tujuego con una excelente calidad de visualización, compatible tanto para Play Station como para Xbox.', 'https://i.imgur.com/tdseyI5.jpg', 666435, 'Elgato', 'Negro', 2019, 35, 0.15),
(5, 'Live Gamer Portable 2 Plus', 'Adecuado para cualquier transmisor; creadores de contenido o aficionados, nuevos o experimentados, esta tarjeta de captura portátil te permite disfrutar de un juego 4K y editar fácilmente en 1080p60.', 'https://i.imgur.com/wz8UDSd.jpg', 465773, 'AVerMedia', 'Negro', 2017, 37, 0.12),
(5, 'AVerMedia Live Gamer Ultra GC553', 'Eleva tu experiencia de grabación y transmisión con la tarjeta de captura AVerMedia Live Gamer ULTRA GC553. Captura y graba un juego HDR 4Kp60 con latencia ultra baja para una experiencia inmersiva en multiples plataformas.', 'https://i.imgur.com/YBNmldK.jpg', 575991, 'AVerMedia', 'Negro', 2018, 38, 0.11),
(5, 'Tarjeta De Captura Live Gamer Duo', 'Tarjeta dual de captura de video sin comprimir de 1080p: el Live Gamer Duo viene con doble entrada HDMI, ambas en una sola ranura; soporta tanto consolas o juegos de PC como tu cámara DSLR o sin espejo; perfecto para plataformas de transmisión en vivo como TwitchTV o YouTube.', 'https://i.imgur.com/m95Axfm.jpg', 850522, 'AVerMedia', 'Negro', 2020, 24, 0.15),
(5, 'Capturadora Externa Razer Ripsaw HD', 'La Razer Ripsaw HD ofrece captura en Full HD 1080p a 60 FPS, ideal para transmisiones de alta calidad. Con passthrough de 4K a 60 FPS, garantiza un juego fluido sin interrupciones.', 'https://i.imgur.com/4f2ovOr.png', 791449, 'Razer', 'Negro', 2019, 35, 0.07),
(5, 'Razer Ripsaw X', 'Captura 4K a 30 FPS: Transmita una calidad de video nítida en 1080p 60 FPS o hasta 4K 30 FPS con DSLR, cámaras portátiles y más a medida que captura cada fotograma para una experiencia de visualización sin concesiones.', 'https://i.imgur.com/1w98m1x.jpg', 498598, 'Razer', 'Negro', 2021, 49, 0.07),
(5, 'Tarjeta de Captura de Video y de Audio', 'Alta calidad HD de 1080P: captura resolución de hasta 1080p para fuente de video y es ideal para todos los dispositivos HDMI como PS4, PS3, Xbox One, Xbox 360, Wii U, DVDs, DSLR, cámara, cámara de seguridad, etc.', 'https://i.imgur.com/3KzxRMD.jpg', 99144, 'Rybozen', 'Negro', 2020, 33, 0.11),
(5, 'Hauppauge HD PVR Rocket', 'Grabadora de video HD portátil, alimentada por USB, que permite grabar directamente en una unidad USB. Incluye mezclador de micrófono integrado para agregar comentarios de juego. Compatible con PC para grabar, editar y transmitir fácilmente.', 'https://i.imgur.com/SKM2msY.jpg', 297963, 'Hauppauge', 'Negro', 2013, 26, 0.08),
(6, 'LG UltraGear 27GL850', 'Monitor Nano IPS de 27 pulgadas QHD (2560x1440) con soporte para NVidia G-Sync y frecuencia de actualización de 144 Hz. Ofrece un ángulo de visión amplio de 178˚ y cuenta con bisel ultrafino. ', 'https://i.imgur.com/Samf6Li.jpg', 866636, 'LG', 'Negro', 2019, 44, 0.07),
(6, 'Pantalla LG 27UN850W', 'Pantalla IPS ultra delgada UHD de 27 pulgadas con cable USB-C que suministra una potencia de 60W y una gama de colores SRGB del 99% con bordes binos y altura ajustable.', 'https://i.imgur.com/jftzQAr.jpg', 994495, 'LG', 'Negro', 2018, 46, 0.09),
(6, 'LG UltraWide QHD 34WQ73A', 'Disfruta de más espacio para reuniones en línea, seminarios web y trabajar con múltiples informes simultáneamente gracias a esta pantalla IPS QHD con formato ultraancho 21:9. Mejora tu productividad y multitarea con este monitor curvo, ideal para aplicaciones empresariales.', 'https://i.imgur.com/pnLdi5i.jpg', 1506847, 'LG', 'Plateado', 2020, 31, 0.11),
(6, 'Acer KB272 E0bi 27"', 'Imágenes increíbles: El monitor Acer KB272 E0bi de 27" con resolución Full HD de 1920 x 1080 en una relación de aspecto de 16:9 presenta imágenes impresionantes y de alta calidad con excelentes detalles. El diseño de marco cero proporciona la máxima visibilidad de la pantalla de borde a borde.', 'https://i.imgur.com/r87Dhrz.jpg', 371870, 'Acer', 'Negro', 2021, 36, 0.15),
(6, 'Acer CB272 Monitor de Oficina', 'Imágenes increíbles: El monitor Acer KB272 E0bi de 27" con resolución Full HD de 1920 x 1080 en una relación de aspecto de 16:9 presenta imágenes impresionantes y de alta calidad con excelentes detalles. El diseño de marco cero proporciona la máxima visibilidad de la pantalla de borde a borde.', 'https://i.imgur.com/ClARnHt.jpg', 509676, 'Acer', 'Negro', 2020, 40, 0.08),
(6, 'Acer Nitro KG24', 'Monitor VA de 23.8 pulgadas Full HD (1920x1080) con AMD FreeSync Premium, frecuencia de actualización de 165 Hz y tiempo de respuesta de 1 ms (VRB). Cuenta con diseño ZeroFrame, compatibilidad HDR y soporte para montaje VESA.', 'https://i.imgur.com/MK2e15X.jpg', 399190, 'Acer', 'Negro', 2019, 31, 0.05),
(6, 'Samsung Odyssey G3', 'la frecuencia de actualización de 180 Hz elimina el retraso para un juego emocionante con acción ultrassuave; el tiempo de respuesta de 1 ms (MPRT) proporciona cuadros con un mínimo de desenfoque, lo que te permite saltar sobre los enemigos justo cuando los veas.', 'https://i.imgur.com/KwTaOF5.jpg', 552430, 'Samsung', 'Negro', 2021, 29, 0.07),
(6, 'Monitor Samsung T35F 27"', ' La pantalla sin bordes de 3 lados aporta una estética limpia y moderna a cualquier entorno de trabajo. En una configuración de varios monitores, las pantallas se alinean sin problemas para una vista prácticamente sin interrupciones. Relación de aspecto: 16:9. Tiempo de respuesta: 5.0 milisegundos', 'https://i.imgur.com/225rv1x.jpg', 452143, 'Samsung', 'Negro', 2020, 27, 0.12),
(6, 'Samsung Essential S3 de 27"', 'Una experiencia de visualización inmersiva con un monitor curvo que envuelve más de cerca su campo de visión; crea una visión más amplia, mejorando la percepción de profundidad y minimizando la distracción periférica.', 'https://i.imgur.com/pM8VOOU.jpg', 477736, 'Samsung', 'Negro', 2019, 45, 0.06);