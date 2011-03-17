class DonationController {
    def scaffold = ItemDonation
            
    def confirmation = {
        [itemDonation : ItemDonation.get(params.id)]
    }
}