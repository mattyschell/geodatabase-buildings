
--manually create badbbls version under edit version

call sde.version_util.set_current_version('badbbls');

--start editing
call sde.version_user_ddl.edit_version ('badbbls', 1);

--update bldg.building_evw set base_bbl = 2054220036 where doitt_id = 386203;--former 2054220035

update bldg.building_evw set base_bbl = 3004620006 where doitt_id = 391521;
update bldg.building_evw set base_bbl = 1009000055 where doitt_id = 391612;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 392776;
update bldg.building_evw set base_bbl = 2028690053 where doitt_id = 393239;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 393473;
update bldg.building_evw set base_bbl = 4096570001 where doitt_id = 401466;
update bldg.building_evw set base_bbl = 2025770063 where doitt_id = 402197;
update bldg.building_evw set base_bbl = 3053840049 where doitt_id = 405360;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 405601;
update bldg.building_evw set base_bbl = 4161560137 where doitt_id = 410909;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 411923;
update bldg.building_evw set base_bbl = 1021980001 where doitt_id = 412438;
update bldg.building_evw set base_bbl = 3050800075 where doitt_id = 413693;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 413937;
update bldg.building_evw set base_bbl = 4027730058 where doitt_id = 414341;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 415369;
update bldg.building_evw set base_bbl = 3056730042 where doitt_id = 417339;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 418042;
update bldg.building_evw set base_bbl = 4022920007 where doitt_id = 418448;
update bldg.building_evw set base_bbl = 1020950031 where doitt_id = 420182;
update bldg.building_evw set base_bbl = 3004270061 where doitt_id = 421191;
update bldg.building_evw set base_bbl = 3006800026 where doitt_id = 424178;
update bldg.building_evw set base_bbl = 1008910044 where doitt_id = 424917;
update bldg.building_evw set base_bbl = 1015080004 where doitt_id = 427043;
update bldg.building_evw set base_bbl = 4161560158 where doitt_id = 431068;
update bldg.building_evw set base_bbl = 3002800015 where doitt_id = 431771;
update bldg.building_evw set base_bbl = 3087160073 where doitt_id = 432227;
update bldg.building_evw set base_bbl = 3013060028 where doitt_id = 440550;
update bldg.building_evw set base_bbl = 4013230029 where doitt_id = 440583;
update bldg.building_evw set base_bbl = 3058090007 where doitt_id = 442759;
update bldg.building_evw set base_bbl = 2023070017 where doitt_id = 443678;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 444835;
update bldg.building_evw set base_bbl = 4100270010 where doitt_id = 446638;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 449335;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 449488;
update bldg.building_evw set base_bbl = 3055010061 where doitt_id = 452983;
update bldg.building_evw set base_bbl = 3039590011 where doitt_id = 453147;
update bldg.building_evw set base_bbl = 3023250004 where doitt_id = 453408;
update bldg.building_evw set base_bbl = 5065340044 where doitt_id = 453457;
update bldg.building_evw set base_bbl = 4050340012 where doitt_id = 457360;
update bldg.building_evw set base_bbl = 3052750078 where doitt_id = 457393;
update bldg.building_evw set base_bbl = 1007380054 where doitt_id = 457516;
update bldg.building_evw set base_bbl = 1001790043 where doitt_id = 458640;
update bldg.building_evw set base_bbl = 3056440021 where doitt_id = 460530;
update bldg.building_evw set base_bbl = 3086720033 where doitt_id = 462861;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 462867;
update bldg.building_evw set base_bbl = 4101150053 where doitt_id = 464039;
update bldg.building_evw set base_bbl = 1004150067 where doitt_id = 464366;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 465630;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 465772;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 465889;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 465977;
update bldg.building_evw set base_bbl = 3070900048 where doitt_id = 466000;
update bldg.building_evw set base_bbl = 3031970034 where doitt_id = 466192;
update bldg.building_evw set base_bbl = 3063590037 where doitt_id = 467436;
update bldg.building_evw set base_bbl = 4161560130 where doitt_id = 470414;
update bldg.building_evw set base_bbl = 4161560136 where doitt_id = 470857;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 470904;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 471561;
update bldg.building_evw set base_bbl = 4000330040 where doitt_id = 471961;
update bldg.building_evw set base_bbl = 1014910021 where doitt_id = 472654;
update bldg.building_evw set base_bbl = 4161560131 where doitt_id = 473651;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 475923;
update bldg.building_evw set base_bbl = 1013960025 where doitt_id = 476135;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 478167;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 481282;
update bldg.building_evw set base_bbl = 4096570001 where doitt_id = 483390;
update bldg.building_evw set base_bbl = 2024060034 where doitt_id = 483415;
update bldg.building_evw set base_bbl = 3057330063 where doitt_id = 484512;
update bldg.building_evw set base_bbl = 2033040136 where doitt_id = 489330;
update bldg.building_evw set base_bbl = 5010700062 where doitt_id = 489668;
update bldg.building_evw set base_bbl = 3006550031 where doitt_id = 491762;
update bldg.building_evw set base_bbl = 1004100068 where doitt_id = 495208;
update bldg.building_evw set base_bbl = 2033050051 where doitt_id = 495239;
update bldg.building_evw set base_bbl = 3036740013 where doitt_id = 495988;
update bldg.building_evw set base_bbl = 3023270023 where doitt_id = 496603;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 498640;
update bldg.building_evw set base_bbl = 1003480048 where doitt_id = 503554;
update bldg.building_evw set base_bbl = 4012820123 where doitt_id = 504197;
update bldg.building_evw set base_bbl = 2029950042 where doitt_id = 504550;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 506002;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 508989;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 513154;
update bldg.building_evw set base_bbl = 1012320045 where doitt_id = 516073;
update bldg.building_evw set base_bbl = 4054190023 where doitt_id = 516268;
update bldg.building_evw set base_bbl = 4161560127 where doitt_id = 517937;
update bldg.building_evw set base_bbl = 1003480048 where doitt_id = 519112;
update bldg.building_evw set base_bbl = 4161560125 where doitt_id = 524468;
update bldg.building_evw set base_bbl = 3013940007 where doitt_id = 526062;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 528734;
update bldg.building_evw set base_bbl = 3006210001 where doitt_id = 529782;
update bldg.building_evw set base_bbl = 2050220001 where doitt_id = 530571;
update bldg.building_evw set base_bbl = 4033930062 where doitt_id = 530765;
update bldg.building_evw set base_bbl = 5010840059 where doitt_id = 534818;
update bldg.building_evw set base_bbl = 4049770001 where doitt_id = 538893;
update bldg.building_evw set base_bbl = 3057330063 where doitt_id = 540889;
update bldg.building_evw set base_bbl = 3031370049 where doitt_id = 541181;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 544108;
update bldg.building_evw set base_bbl = 1009000055 where doitt_id = 544843;
update bldg.building_evw set base_bbl = 1015480023 where doitt_id = 545020;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 545695;
update bldg.building_evw set base_bbl = 1013220008 where doitt_id = 545735;
update bldg.building_evw set base_bbl = 1001790043 where doitt_id = 546636;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 547355;
update bldg.building_evw set base_bbl = 3007150001 where doitt_id = 547545;
update bldg.building_evw set base_bbl = 3020200068 where doitt_id = 547583;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 549998;
update bldg.building_evw set base_bbl = 3032650042 where doitt_id = 551120;
update bldg.building_evw set base_bbl = 1006090039 where doitt_id = 551890;
update bldg.building_evw set base_bbl = 3032650042 where doitt_id = 554521;
update bldg.building_evw set base_bbl = 2046630024 where doitt_id = 555503;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 555534;
update bldg.building_evw set base_bbl = 1006090039 where doitt_id = 556247;
update bldg.building_evw set base_bbl = 3071270009 where doitt_id = 559575;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 561189;
update bldg.building_evw set base_bbl = 3052970066 where doitt_id = 564083;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 566008;
update bldg.building_evw set base_bbl = 4161560149 where doitt_id = 566302;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 566441;
update bldg.building_evw set base_bbl = 4116890055 where doitt_id = 567713;
update bldg.building_evw set base_bbl = 4161560129 where doitt_id = 567723;

commit;

call sde.version_user_ddl.edit_version ('badbbls', 2);

--reconcile and post and delete badbbls 
