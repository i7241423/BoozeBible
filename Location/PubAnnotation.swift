import MapKit

class PubAnnotation: MKPointAnnotation {
    
    var pub: Pub!

    init(pub: Pub) {
        super.init()
        self.pub = pub
        coordinate = pub.location
        title = pub.name
        subtitle = pub.sub
    }
    
    
    
    

    
}
