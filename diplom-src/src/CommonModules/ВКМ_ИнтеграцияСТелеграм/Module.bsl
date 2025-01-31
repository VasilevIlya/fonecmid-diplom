#Область СлужебныеПроцедурыИФункции
Процедура ОтправкаУведомленияТелеграмБоту()Экспорт
	
	Выборка = Справочники.ВКМ_УведомленияТелеграмБоту.Выбрать();
	Пока Выборка.Следующий() Цикл
		ТекстСообщения = Выборка.ТекстСообщения;
		ОтправитьСообщениеТелеграмБоту(ТекстСообщения);
		Выборка.ПолучитьОбъект().Удалить();
	КонецЦикла;
	
КонецПроцедуры

Процедура ОтправитьСообщениеТелеграмБоту(ТекстСообщения) 
	
	ГруппаID 	= Константы.ВКМ_ИдентификаторГруппыДляОповещения.Получить(); 
	Токен 		= Константы.ВКМ_ТокенУправленияТелеграмБотом.Получить();
	
	Ресурс = "bot"+Токен+"/sendMessage?chat_id="+ГруппаID+"&text="+ТекстСообщения;
	
	Соединение = Новый HTTPСоединение("api.telegram.org",,,,,,Новый ЗащищенноеСоединениеOpenSSL);
	
	Запрос = Новый HTTPЗапрос(Ресурс); 
	Запрос.Заголовки.Вставить("Content-type","application/json"); 
	
	Ответ = Соединение.Получить(Запрос); 
	
	Если Ответ.КодСостояния <> 200 Тогда
		//@skip-check object-deprecated
		СтрокаОтвета = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации("HTTPСервисы.Ошибка",УровеньЖурналаРегистрации.Ошибка,,,СтрокаОтвета,);
	КонецЕсли;
	
	ЗаписьЖурналаРегистрации("HTTPСервисы.Отправка",УровеньЖурналаРегистрации.Информация,,,"Сообщение отправлено",);
	
КонецПроцедуры

#КонецОбласти