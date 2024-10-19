Class {
	#name : #IonDatetime,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonDatetime >> cancel [

	"Emits the ionCancel event and optionally closes the popover or modal that the datetime was presented in.
	
	Type: (closeOverlay?: boolean) => Promise<void>"

	^ self apply: #cancel resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonDatetime >> cancel: closeOverlay [

	"Emits the ionCancel event and optionally closes the popover or modal that the datetime was presented in.
	
	Type: (closeOverlay?: boolean) => Promise<void>"

	^ self apply: #cancel withArguments: { closeOverlay } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonDatetime >> cancelText [

	"The text to display on the picker's cancel button.
	
	Type: string"

	^ self propertyAt: #cancelText
]

{ #category : #api }
IonDatetime >> cancelText: aString [

	"The text to display on the picker's cancel button.
	
	Type: string"

	self propertyAt: #cancelText put: aString
]

{ #category : #api }
IonDatetime >> clearText [

	"The text to display on the picker's 'Clear' button.
	
	Type: string"

	^ self propertyAt: #clearText
]

{ #category : #api }
IonDatetime >> clearText: aString [

	"The text to display on the picker's 'Clear' button.
	
	Type: string"

	self propertyAt: #clearText put: aString
]

{ #category : #api }
IonDatetime >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonDatetime >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonDatetime >> confirm [

	"Confirms the selected datetime value, updates the 'value' property, and optionally closes the popover or modal that the datetime was presented in.
	
	Type: (closeOverlay?: boolean) => Promise<void>"

	^ self apply: #confirm resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonDatetime >> confirm: closeOverlay [

	"Confirms the selected datetime value, updates the 'value' property, and optionally closes the popover or modal that the datetime was presented in.
	
	Type: (closeOverlay?: boolean) => Promise<void>"

	^ self apply: #confirm withArguments: { closeOverlay } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonDatetime >> dayValues [

	"Values used to create the list of selectable days. By default every day is shown for the given month. However, to control exactly which days of the month to display, the 'dayValues' input can take a number, an array of numbers, or a string of comma separated numbers. Note that even if the array days have an invalid number for the selected month, like '31' in February, it will correctly not show days which are not valid for the selected month.
	
	Type: number[] | number | string"

	^ self propertyAt: #dayValues
]

{ #category : #api }
IonDatetime >> dayValues: anObject [

	"Values used to create the list of selectable days. By default every day is shown for the given month. However, to control exactly which days of the month to display, the 'dayValues' input can take a number, an array of numbers, or a string of comma separated numbers. Note that even if the array days have an invalid number for the selected month, like '31' in February, it will correctly not show days which are not valid for the selected month.
	
	Type: number[] | number | string"

	self propertyAt: #dayValues put: anObject
]

{ #category : #api }
IonDatetime >> disabled [

	"If 'true', the user cannot interact with the datetime.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonDatetime >> disabled: aBoolean [

	"If 'true', the user cannot interact with the datetime.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonDatetime >> doneText [

	"The text to display on the picker's 'Done' button.
	
	Type: string"

	^ self propertyAt: #doneText
]

{ #category : #api }
IonDatetime >> doneText: aString [

	"The text to display on the picker's 'Done' button.
	
	Type: string"

	self propertyAt: #doneText put: aString
]

{ #category : #api }
IonDatetime >> firstDayOfWeek [

	"The first day of the week to use for 'ion-datetime'. The default value is '0' and represents Sunday.
	
	Type: number"

	^ self propertyAt: #firstDayOfWeek
]

{ #category : #api }
IonDatetime >> firstDayOfWeek: aNumber [

	"The first day of the week to use for 'ion-datetime'. The default value is '0' and represents Sunday.
	
	Type: number"

	self propertyAt: #firstDayOfWeek put: aNumber
]

{ #category : #api }
IonDatetime >> formatOptions [

	"Formatting options for dates and times. Should include a 'date' and/or 'time' object, each of which is of type [Intl.DateTimeFormatOptions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/DateTimeFormat/DateTimeFormat#options).
	
	Type: FormatOptions"

	^ self propertyAt: #formatOptions
]

{ #category : #api }
IonDatetime >> formatOptions: anObject [

	"Formatting options for dates and times. Should include a 'date' and/or 'time' object, each of which is of type [Intl.DateTimeFormatOptions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/DateTimeFormat/DateTimeFormat#options).
	
	Type: FormatOptions"

	self propertyAt: #formatOptions put: anObject
]

{ #category : #api }
IonDatetime >> highlightedDates [

	"Used to apply custom text and background colors to specific dates.  Can be either an array of objects containing ISO strings and colors, or a callback that receives an ISO string and returns the colors.  Only applies to the 'date', 'date-time', and 'time-date' presentations, with 'preferWheel='false''.
	
	Type: DatetimeHighlight[] | DatetimeHighlightCallback"

	^ self propertyAt: #highlightedDates
]

{ #category : #api }
IonDatetime >> highlightedDates: anObject [

	"Used to apply custom text and background colors to specific dates.  Can be either an array of objects containing ISO strings and colors, or a callback that receives an ISO string and returns the colors.  Only applies to the 'date', 'date-time', and 'time-date' presentations, with 'preferWheel='false''.
	
	Type: DatetimeHighlight[] | DatetimeHighlightCallback"

	self propertyAt: #highlightedDates put: anObject
]

{ #category : #api }
IonDatetime >> hourCycle [

	"The hour cycle of the 'ion-datetime'. If no value is set, this is specified by the current locale.
	
	Type: DatetimeHourCycle"

	^ self propertyAt: #hourCycle
]

{ #category : #api }
IonDatetime >> hourCycle: anObject [

	"The hour cycle of the 'ion-datetime'. If no value is set, this is specified by the current locale.
	
	Type: DatetimeHourCycle"

	self propertyAt: #hourCycle put: anObject
]

{ #category : #api }
IonDatetime >> hourValues [

	"Values used to create the list of selectable hours. By default the hour values range from '0' to '23' for 24-hour, or '1' to '12' for 12-hour. However, to control exactly which hours to display, the 'hourValues' input can take a number, an array of numbers, or a string of comma separated numbers.
	
	Type: number[] | number | string"

	^ self propertyAt: #hourValues
]

{ #category : #api }
IonDatetime >> hourValues: anObject [

	"Values used to create the list of selectable hours. By default the hour values range from '0' to '23' for 24-hour, or '1' to '12' for 12-hour. However, to control exactly which hours to display, the 'hourValues' input can take a number, an array of numbers, or a string of comma separated numbers.
	
	Type: number[] | number | string"

	self propertyAt: #hourValues put: anObject
]

{ #category : #api }
IonDatetime >> isDateEnabled: dateIsoString [

	"Returns if an individual date (calendar day) is enabled or disabled.  If 'true', the day will be enabled/interactive. If 'false', the day will be disabled/non-interactive.  The function accepts an ISO 8601 date string of a given day. By default, all days are enabled. Developers can use this function to write custom logic to disable certain days.  The function is called for each rendered calendar day, for the previous, current and next month. Custom implementations should be optimized for performance to avoid jank.
	
	Type: (dateIsoString: string) => boolean"

	^ self apply: #isDateEnabled withArguments: { dateIsoString } resultAs: Object
]

{ #category : #api }
IonDatetime >> locale [

	"The locale to use for 'ion-datetime'. This impacts month and day name formatting. The ''default'' value refers to the default locale set by your device.
	
	Type: string"

	^ self propertyAt: #locale
]

{ #category : #api }
IonDatetime >> locale: aString [

	"The locale to use for 'ion-datetime'. This impacts month and day name formatting. The ''default'' value refers to the default locale set by your device.
	
	Type: string"

	self propertyAt: #locale put: aString
]

{ #category : #api }
IonDatetime >> max [

	"The maximum datetime allowed. Value must be a date string following the [ISO 8601 datetime format standard](https://www.w3.org/TR/NOTE-datetime), '1996-12-19'. The format does not have to be specific to an exact datetime. For example, the maximum could just be the year, such as '1994'. Defaults to the end of this year.
	
	Type: string"

	^ self propertyAt: #max
]

{ #category : #api }
IonDatetime >> max: aString [

	"The maximum datetime allowed. Value must be a date string following the [ISO 8601 datetime format standard](https://www.w3.org/TR/NOTE-datetime), '1996-12-19'. The format does not have to be specific to an exact datetime. For example, the maximum could just be the year, such as '1994'. Defaults to the end of this year.
	
	Type: string"

	self propertyAt: #max put: aString
]

{ #category : #api }
IonDatetime >> min [

	"The minimum datetime allowed. Value must be a date string following the [ISO 8601 datetime format standard](https://www.w3.org/TR/NOTE-datetime), such as '1996-12-19'. The format does not have to be specific to an exact datetime. For example, the minimum could just be the year, such as '1994'. Defaults to the beginning of the year, 100 years ago from today.
	
	Type: string"

	^ self propertyAt: #min
]

{ #category : #api }
IonDatetime >> min: aString [

	"The minimum datetime allowed. Value must be a date string following the [ISO 8601 datetime format standard](https://www.w3.org/TR/NOTE-datetime), such as '1996-12-19'. The format does not have to be specific to an exact datetime. For example, the minimum could just be the year, such as '1994'. Defaults to the beginning of the year, 100 years ago from today.
	
	Type: string"

	self propertyAt: #min put: aString
]

{ #category : #api }
IonDatetime >> minuteValues [

	"Values used to create the list of selectable minutes. By default the minutes range from '0' to '59'. However, to control exactly which minutes to display, the 'minuteValues' input can take a number, an array of numbers, or a string of comma separated numbers. For example, if the minute selections should only be every 15 minutes, then this input value would be 'minuteValues='0,15,30,45''.
	
	Type: number[] | number | string"

	^ self propertyAt: #minuteValues
]

{ #category : #api }
IonDatetime >> minuteValues: anObject [

	"Values used to create the list of selectable minutes. By default the minutes range from '0' to '59'. However, to control exactly which minutes to display, the 'minuteValues' input can take a number, an array of numbers, or a string of comma separated numbers. For example, if the minute selections should only be every 15 minutes, then this input value would be 'minuteValues='0,15,30,45''.
	
	Type: number[] | number | string"

	self propertyAt: #minuteValues put: anObject
]

{ #category : #api }
IonDatetime >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonDatetime >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonDatetime >> monthValues [

	"Values used to create the list of selectable months. By default the month values range from '1' to '12'. However, to control exactly which months to display, the 'monthValues' input can take a number, an array of numbers, or a string of comma separated numbers. For example, if only summer months should be shown, then this input value would be 'monthValues='6,7,8''. Note that month numbers do *not* have a zero-based index, meaning January's value is '1', and December's is '12'.
	
	Type: number[] | number | string"

	^ self propertyAt: #monthValues
]

{ #category : #api }
IonDatetime >> monthValues: anObject [

	"Values used to create the list of selectable months. By default the month values range from '1' to '12'. However, to control exactly which months to display, the 'monthValues' input can take a number, an array of numbers, or a string of comma separated numbers. For example, if only summer months should be shown, then this input value would be 'monthValues='6,7,8''. Note that month numbers do *not* have a zero-based index, meaning January's value is '1', and December's is '12'.
	
	Type: number[] | number | string"

	self propertyAt: #monthValues put: anObject
]

{ #category : #api }
IonDatetime >> multiple [

	"If 'true', multiple dates can be selected at once. Only applies to 'presentation='date'' and 'preferWheel='false''.
	
	Type: boolean"

	^ self propertyAt: #multiple
]

{ #category : #api }
IonDatetime >> multiple: aBoolean [

	"If 'true', multiple dates can be selected at once. Only applies to 'presentation='date'' and 'preferWheel='false''.
	
	Type: boolean"

	self propertyAt: #multiple put: aBoolean
]

{ #category : #api }
IonDatetime >> name [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	^ self propertyAt: #name
]

{ #category : #api }
IonDatetime >> name: aString [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	self propertyAt: #name put: aString
]

{ #category : #api }
IonDatetime >> preferWheel [

	"If 'true', a wheel picker will be rendered instead of a calendar grid where possible. If 'false', a calendar grid will be rendered instead of a wheel picker where possible.  A wheel picker can be rendered instead of a grid when 'presentation' is one of the following values: ''date'', ''date-time'', or ''time-date''.  A wheel picker will always be rendered regardless of the 'preferWheel' value when 'presentation' is one of the following values: ''time'', ''month'', ''month-year'', or ''year''.
	
	Type: boolean"

	^ self propertyAt: #preferWheel
]

{ #category : #api }
IonDatetime >> preferWheel: aBoolean [

	"If 'true', a wheel picker will be rendered instead of a calendar grid where possible. If 'false', a calendar grid will be rendered instead of a wheel picker where possible.  A wheel picker can be rendered instead of a grid when 'presentation' is one of the following values: ''date'', ''date-time'', or ''time-date''.  A wheel picker will always be rendered regardless of the 'preferWheel' value when 'presentation' is one of the following values: ''time'', ''month'', ''month-year'', or ''year''.
	
	Type: boolean"

	self propertyAt: #preferWheel put: aBoolean
]

{ #category : #api }
IonDatetime >> presentation [

	"Which values you want to select. ''date'' will show a calendar picker to select the month, day, and year. ''time'' will show a time picker to select the hour, minute, and (optionally) AM/PM. ''date-time'' will show the date picker first and time picker second. ''time-date'' will show the time picker first and date picker second.
	
	Type: DatetimePresentation"

	^ self propertyAt: #presentation
]

{ #category : #api }
IonDatetime >> presentation: anObject [

	"Which values you want to select. ''date'' will show a calendar picker to select the month, day, and year. ''time'' will show a time picker to select the hour, minute, and (optionally) AM/PM. ''date-time'' will show the date picker first and time picker second. ''time-date'' will show the time picker first and date picker second.
	
	Type: DatetimePresentation"

	self propertyAt: #presentation put: anObject
]

{ #category : #api }
IonDatetime >> readonly [

	"If 'true', the datetime appears normal but the selected date cannot be changed.
	
	Type: boolean"

	^ self propertyAt: #readonly
]

{ #category : #api }
IonDatetime >> readonly: aBoolean [

	"If 'true', the datetime appears normal but the selected date cannot be changed.
	
	Type: boolean"

	self propertyAt: #readonly put: aBoolean
]

{ #category : #api }
IonDatetime >> reset [

	"Resets the internal state of the datetime but does not update the value. Passing a valid ISO-8601 string will reset the state of the component to the provided date. If no value is provided, the internal state will be reset to the clamped value of the min, max and today.
	
	Type: (startDate?: string) => Promise<void>"

	^ self apply: #reset resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonDatetime >> reset: startDate [

	"Resets the internal state of the datetime but does not update the value. Passing a valid ISO-8601 string will reset the state of the component to the provided date. If no value is provided, the internal state will be reset to the clamped value of the min, max and today.
	
	Type: (startDate?: string) => Promise<void>"

	^ self apply: #reset withArguments: { startDate } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonDatetime >> showClearButton [

	"If 'true', a 'Clear' button will be rendered alongside the default 'Cancel' and 'OK' buttons at the bottom of the 'ion-datetime' component. Developers can also use the 'button' slot if they want to customize these buttons. If custom buttons are set in the 'button' slot then the default buttons will not be rendered.
	
	Type: boolean"

	^ self propertyAt: #showClearButton
]

{ #category : #api }
IonDatetime >> showClearButton: aBoolean [

	"If 'true', a 'Clear' button will be rendered alongside the default 'Cancel' and 'OK' buttons at the bottom of the 'ion-datetime' component. Developers can also use the 'button' slot if they want to customize these buttons. If custom buttons are set in the 'button' slot then the default buttons will not be rendered.
	
	Type: boolean"

	self propertyAt: #showClearButton put: aBoolean
]

{ #category : #api }
IonDatetime >> showDefaultButtons [

	"If 'true', the default 'Cancel' and 'OK' buttons will be rendered at the bottom of the 'ion-datetime' component. Developers can also use the 'button' slot if they want to customize these buttons. If custom buttons are set in the 'button' slot then the default buttons will not be rendered.
	
	Type: boolean"

	^ self propertyAt: #showDefaultButtons
]

{ #category : #api }
IonDatetime >> showDefaultButtons: aBoolean [

	"If 'true', the default 'Cancel' and 'OK' buttons will be rendered at the bottom of the 'ion-datetime' component. Developers can also use the 'button' slot if they want to customize these buttons. If custom buttons are set in the 'button' slot then the default buttons will not be rendered.
	
	Type: boolean"

	self propertyAt: #showDefaultButtons put: aBoolean
]

{ #category : #api }
IonDatetime >> showDefaultTimeLabel [

	"If 'true', the default 'Time' label will be rendered for the time selector of the 'ion-datetime' component. Developers can also use the 'time-label' slot if they want to customize this label. If a custom label is set in the 'time-label' slot then the default label will not be rendered.
	
	Type: boolean"

	^ self propertyAt: #showDefaultTimeLabel
]

{ #category : #api }
IonDatetime >> showDefaultTimeLabel: aBoolean [

	"If 'true', the default 'Time' label will be rendered for the time selector of the 'ion-datetime' component. Developers can also use the 'time-label' slot if they want to customize this label. If a custom label is set in the 'time-label' slot then the default label will not be rendered.
	
	Type: boolean"

	self propertyAt: #showDefaultTimeLabel put: aBoolean
]

{ #category : #api }
IonDatetime >> showDefaultTitle [

	"If 'true', a header will be shown above the calendar picker. This will include both the slotted title, and the selected date.
	
	Type: boolean"

	^ self propertyAt: #showDefaultTitle
]

{ #category : #api }
IonDatetime >> showDefaultTitle: aBoolean [

	"If 'true', a header will be shown above the calendar picker. This will include both the slotted title, and the selected date.
	
	Type: boolean"

	self propertyAt: #showDefaultTitle put: aBoolean
]

{ #category : #api }
IonDatetime >> size [

	"If 'cover', the 'ion-datetime' will expand to cover the full width of its container. If 'fixed', the 'ion-datetime' will have a fixed width.
	
	Type: 'cover' | 'fixed'"

	^ self propertyAt: #size
]

{ #category : #api }
IonDatetime >> size: aString [

	"If 'cover', the 'ion-datetime' will expand to cover the full width of its container. If 'fixed', the 'ion-datetime' will have a fixed width.
	
	Type: 'cover' | 'fixed'"

	self propertyAt: #size put: aString
]

{ #category : #api }
IonDatetime >> titleSelectedDatesFormatter [

	"A callback used to format the header text that shows how many dates are selected. Only used if there are 0 or more than 1 selected (i.e. unused for exactly 1). By default, the header text is set to 'numberOfDates days'.  See https://ionicframework.com/docs/troubleshooting/runtime#accessing-this if you need to access 'this' from within the callback.
	
	Type: TitleSelectedDatesFormatter"

	^ self propertyAt: #titleSelectedDatesFormatter
]

{ #category : #api }
IonDatetime >> titleSelectedDatesFormatter: anObject [

	"A callback used to format the header text that shows how many dates are selected. Only used if there are 0 or more than 1 selected (i.e. unused for exactly 1). By default, the header text is set to 'numberOfDates days'.  See https://ionicframework.com/docs/troubleshooting/runtime#accessing-this if you need to access 'this' from within the callback.
	
	Type: TitleSelectedDatesFormatter"

	self propertyAt: #titleSelectedDatesFormatter put: anObject
]

{ #category : #api }
IonDatetime >> value [

	"The value of the datetime as a valid ISO 8601 datetime string. This should be an array of strings only when 'multiple='true''.
	
	Type: string | string[] | null"

	^ self propertyAt: #value
]

{ #category : #api }
IonDatetime >> value: anObject [

	"The value of the datetime as a valid ISO 8601 datetime string. This should be an array of strings only when 'multiple='true''.
	
	Type: string | string[] | null"

	self propertyAt: #value put: anObject
]

{ #category : #api }
IonDatetime >> yearValues [

	"Values used to create the list of selectable years. By default the year values range between the 'min' and 'max' datetime inputs. However, to control exactly which years to display, the 'yearValues' input can take a number, an array of numbers, or string of comma separated numbers. For example, to show upcoming and recent leap years, then this input's value would be 'yearValues='2008,2012,2016,2020,2024''.
	
	Type: number[] | number | string"

	^ self propertyAt: #yearValues
]

{ #category : #api }
IonDatetime >> yearValues: anObject [

	"Values used to create the list of selectable years. By default the year values range between the 'min' and 'max' datetime inputs. However, to control exactly which years to display, the 'yearValues' input can take a number, an array of numbers, or string of comma separated numbers. For example, to show upcoming and recent leap years, then this input's value would be 'yearValues='2008,2012,2016,2020,2024''.
	
	Type: number[] | number | string"

	self propertyAt: #yearValues put: anObject
]
