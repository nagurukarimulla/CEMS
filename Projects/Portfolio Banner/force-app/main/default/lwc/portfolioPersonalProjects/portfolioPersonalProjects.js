import { LightningElement } from 'lwc';
import PortfolioAssets from '@salesforce/resourceUrl/PortfolioAssets'
export default class PortfolioPersonalProjects extends LightningElement {
    BMICalculator = `${PortfolioAssets}/PortfolioAssets/Projects/BMICalculator.png`
    AlarmClock = `${PortfolioAssets}/PortfolioAssets/Projects/AlarmClock.png`
    CurrencyCalculator = `${PortfolioAssets}/PortfolioAssets/Projects/CurrencyCalculator.png`
    WeatherApp = `${PortfolioAssets}/PortfolioAssets/Projects/WeatherApp.png`
    SurveyApp = `${PortfolioAssets}/PortfolioAssets/Projects/Survey.png`
    NoteApp = `${PortfolioAssets}/PortfolioAssets/Projects/NoteTakingApp.png`
    //CarHub = `${PortfolioAssets}/PortfolioAssets/Projects/CarHub.png`

    projects=[
        {
            "name":"BMI Calculator App",
            "img":this.BMICalculator,
            "link":" https://d2w00000qscqeear-dev-ed.develop.my.site.com/bmi-calculator"
        },
        {
            "name":"Alarm Clock App",
            "img":this.AlarmClock,
            "link":" https://d2w00000qscqeear-dev-ed.develop.my.site.com/alarm-clock"
        },
        {
            "name":"Curreny Converter App",
            "img":this.CurrencyCalculator,
            "link":" https://d2w00000qscqeear-dev-ed.develop.my.site.com/currency-converter-app"
        },
        {
            "name":"Weather App",
            "img":this.WeatherApp,
            "link":" https://d2w00000qscqeear-dev-ed.develop.my.site.com/weatherapp"
        },
        {
            "name":"Survey App",
            "img":this.SurveyApp,
            "link":" https://d2w00000qscqeear-dev-ed.develop.my.site.com/runtimeApp.app?invitationId=0Ki5g0000009IHa&surveyName=employee_survey&UUID=ada46bf6-2671-4ea5-a224-43f8508d6a24"
        },
        {
            "name":"Note Taking App",
            "img":this.NoteApp,
            "link":" https://d2w00000qscqeear-dev-ed.develop.my.site.com/note-app"
        }
        // {
        //     "name":"Car Hub Project",
        //     "img":this.CarHub,
        //     "link":"https://cittacoretechnologiesindial-dev-ed.lightning.force.com/lightning/n/Car_Explorer"
        // }
    ]
}