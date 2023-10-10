import { LightningElement, api } from 'lwc';

export default class EmployeePerformanceAssessment extends LightningElement {
  @api employeeName;
  @api employeeTitle;

  assessmentDate;
  managerName;
  goalSettings;
  selectedRating;
  ratingIndicator;

  ratingOptions = [
    { label: 'FE (Far Exceeds)', value: '5' },
    { label: 'EX (Exceeds Expectations)', value: '4' },
    { label: 'ME (Meets Expectations)', value: '3' },
    { label: 'DR (Development Required)', value: '2' },
    { label: 'IR (Improvement Required)', value: '1' }
  ];

  handleAssessmentDateChange(event) {
    this.assessmentDate = event.target.value;
  }

  handleManagerNameChange(event) {
    this.managerName = event.target.value;
  }

  handleGoalSettingsChange(event) {
    this.goalSettings = event.target.value;
  }

  handleRatingChange(event) {
    this.selectedRating = event.detail.value;
    this.ratingIndicator = this.getRatingIndicator(this.selectedRating);
  }

  handleSave() {
    // You can store the data related to ratings and make them available to HR here
    console.log('Assessment Date:', this.assessmentDate);
    console.log('Manager Name:', this.managerName);
    console.log('employeeTitle:', this.employeeTitle);
    console.log('Employee Name:', this.employeeName);
    console.log('Goal Settings:', this.goalSettings);
    console.log('Selected Rating:', this.selectedRating);
    }
    
    getRatingIndicator(rating) {
    let indicator = '';
    switch (rating) {
    case '5':
    indicator = '*****';
    break;
    case '4':
    indicator = '****';
    break;
    case '3':
    indicator = '***';
    break;
    case '2':
    indicator = '**';
    break;
    case '1':
    indicator = '*';
    break;
    default:
    break;
    }
    return indicator;
    }
    }
