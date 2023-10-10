import { LightningElement } from 'lwc';
import USER_IMAGE from '@salesforce/resourceUrl/user_image'
import USER_WALKING_IMG from '@salesforce/resourceUrl/user_walking'
import CAR_HUB_IMG from '@salesforce/resourceUrl/carhub_images'
export default class StaticImages extends LightningElement {
    userImage = USER_IMAGE

    userWalking = USER_WALKING_IMG

    carHubImage = CAR_HUB_IMG
}