from whatsapp_api_client_python import API
from datetime import datetime
from json import dumps
import csv
import sys

greenAPI = API.GreenAPI(
    "1100110011", "23aaf26d900b46b0b699d52add706cc1c35mec248227441c98" #veuillez entrer de vraies informations ici
)

message = ""

def recupere_message(body, type_message, chatId) :
    if (type_message == "textMessage" and chatId == "690909090@c.us") :
        message = body["messageData"]["textMessageData"]["textMessage"]
        return message

def lecture_message():
    greenAPI.webhooks.startReceivingNotifications(handler)
    return

def envoie_message(message) :
    response = greenAPI.sending.sendMessage("690909090@c.us", "Message text")



def handler(type_webhook: str, body: dict) -> None:
    if type_webhook == "incomingMessageReceived":
        incoming_message_received(body)
        return
    elif type_webhook == "outgoingMessageReceived":
        outgoing_message_received(body)
        return
    elif type_webhook == "outgoingAPIMessageReceived":
        outgoing_api_message_received(body)
        return

def get_notification_time(timestamp: int) -> str:
    return str(datetime.fromtimestamp(timestamp))

def incoming_message_received(body: dict) -> None:
    timestamp = body["timestamp"]
    time = get_notification_time(timestamp)

    data = dumps(body, ensure_ascii=False, indent=4)

    print(f"New incoming message at {time} with data: {data}", end="\n\n")

    type_message = body["messageData"]["typeMessage"]
    chatId = body["senderData"]["chatId"]

    if (type_message == "textMessage" and chatId == "690909090@c.us") :
        global message
        message = body["messageData"]["textMessageData"]["textMessage"]
        return message

def outgoing_message_received(body: dict) -> None:
    timestamp = body["timestamp"]
    time = get_notification_time(timestamp)

    data = dumps(body, ensure_ascii=False, indent=4)

    print(f"New outgoing message at {time} with data: {data}", end="\n\n")

    type_message = body["messageData"]["typeMessage"]
    chatId = body["senderData"]["chatId"]

    if (type_message == "textMessage" and chatId == "690909090@c.us") :
        global message
        message = body["messageData"]["textMessageData"]["textMessage"]
        return message

def outgoing_api_message_received(body: dict) -> None:
    timestamp = body["timestamp"]
    time = get_notification_time(timestamp)

    data = dumps(body, ensure_ascii=False, indent=4)

    print(f"New outgoing API message at {time} with data: {data}", end="\n\n")

    type_message = body["messageData"]["typeMessage"]
    chatId = body["senderData"]["chatId"]

    if (type_message == "textMessage" and chatId == "690909090@c.us") :
        global message
        message = body["messageData"]["textMessageData"]["textMessage"]
        return message

def demander_symptome(Symptome, N):
    #reponse = input(f'Ressentez-vous le symptôme suivant : {Symptome} ? (oui/non) ')
    response = greenAPI.sending.sendMessage("690909090@c.us", f"Ressentez-vous le symptôme suivant : {Symptome} ? (oui/non) ")
    lecture_message()
    global message
    reponse = message
    print(reponse)

    if reponse.lower() in ['oui', 'o']:
        poser_question_B(N)
    elif reponse.lower() in ['non', 'n']:
        response = greenAPI.sending.sendMessage("690909090@c.us", "Symptôme non présent.")
        #print('Symptôme non présent.', N)
    else:
        response = greenAPI.sending.sendMessage("690909090@c.us", "Réponse non valide. Veuillez répondre par 'oui' ou 'non'.")
        #print('Réponse non valide. Veuillez répondre par "oui" ou "non".')
        demander_symptome(Symptome, N)

def demander_symptome_B(Symptome, N):
    #reponse = input(f'Ressentez-vous aussi le symptôme suivant : {Symptome} ? (oui/non) ')
    response = greenAPI.sending.sendMessage("690909090@c.us", f"Ressentez-vous aussi le symptôme suivant : {Symptome} ? (oui/non) ")
    lecture_message()
    global message
    reponse = message
    print(reponse)

    if reponse.lower() in ['oui', 'o']:
        poser_question_C(N)
    elif reponse.lower() in ['non', 'n']:
        response = greenAPI.sending.sendMessage("690909090@c.us", "Symptôme non présent.")
        #print('Symptôme non présent.')
        #print('Les symptomes que vous présentez ne correspondent à aucune maladie dans notre base de données.')
        response = greenAPI.sending.sendMessage("690909090@c.us", "Les symptomes que vous présentez ne correspondent à aucune maladie dans notre base de données.")
    else:
        response = greenAPI.sending.sendMessage("690909090@c.us", "Réponse non valide. Veuillez répondre par 'oui' ou 'non'.")
        #print('Réponse non valide. Veuillez répondre par "oui" ou "non".')
        demander_symptome_B(Symptome, N)

def demander_symptome_C(Symptome, n):
    #reponse = input(f'Ressentez-vous aussi le symptôme suivant : {symptome} ? (oui/non) ')
    response = greenAPI.sending.sendMessage("690909090@c.us", f"Ressentez-vous aussi le symptôme suivant : {Symptome} ? (oui/non) ")
    lecture_message()
    global message
    reponse = message
    print(reponse)
    
    if reponse.lower() in ['oui', 'o']:
        poser_question_D(n)
    elif reponse.lower() in ['non', 'n']:
        #print('Symptôme non présent.')
        response = greenAPI.sending.sendMessage("690909090@c.us", "Symptôme non présent.")
        #print('Les symptomes que vous présentez ne correspondent à aucune maladie dans notre base de données.')
        response = greenAPI.sending.sendMessage("690909090@c.us", "Les symptomes que vous présentez ne correspondent à aucune maladie dans notre base de données.")

    else:
        #print('Réponse non valide. Veuillez répondre par "oui" ou "non".')
        response = greenAPI.sending.sendMessage("690909090@c.us", "Réponse non valide. Veuillez répondre par 'oui' ou 'non'.")
        demander_symptome_C(Symptome, n)

def demander_symptome_D(symptome, n):
    #reponse = input(f'Ressentez-vous aussi le symptôme suivant : {symptome} ? (oui/non) ')
    response = greenAPI.sending.sendMessage("690909090@c.us", f"Ressentez-vous aussi le symptôme suivant : {symptome} ? (oui/non) ")
    lecture_message()
    global message
    reponse = message
    print(reponse)
    
    if reponse.lower() in ['oui', 'o']:
        bilan(n)
    elif reponse.lower() in ['non', 'n']:
        #print('Symptôme non présent.')
        response = greenAPI.sending.sendMessage("690909090@c.us", "Symptôme non présent.")
        #print('Les symptomes que vous présentez ne correspondent à aucune maladie dans notre base de données.')
        response = greenAPI.sending.sendMessage("690909090@c.us", "Les symptomes que vous présentez ne correspondent à aucune maladie dans notre base de données.")
    else:
        #print('Réponse non valide. Veuillez répondre par "oui" ou "non".')
        response = greenAPI.sending.sendMessage("690909090@c.us", "Réponse non valide. Veuillez répondre par 'oui' ou 'non'.")
        demander_symptome_D(symptome, n)



def main():
    # Les premiers symptômes qu'on pose au malade.
    demander_symptome("douleur thoracique intense", 0)
    demander_symptome("douleur et pression à la poitrine", 1)
    demander_symptome("essoufflement", 2)
    demander_symptome("douleur/sensibilité à la jambe", 3)
    demander_symptome("essoufflement soudain", 4)
    demander_symptome("maux de tête fréquents", 5)
    demander_symptome("palpitations cardiaques", 6)
    demander_symptome("essoufflement à l'effort", 7)
    demander_symptome("soif excessive", 8)
    demander_symptome("perte de poids inexpliquée", 9)
    demander_symptome("fatigue", 10)
    demander_symptome("prise de poids excessive", 11)
    demander_symptome("respiration sifflante", 12)
    demander_symptome("toux productive", 13)
    # demander_symptome(essoufflement, 14)
    demander_symptome("ronflements forts", 15)
    demander_symptome("fièvre", 16)
    demander_symptome("congestion nasale", 17)
    # demander_symptome("congestion nasale", 18)
    # demander_symptome("fièvre", 19)
    # demander_symptome("fatigue", 20)
    # demander_symptome("fatigue", 21)
    demander_symptome("éruption cutanée", 22)
    demander_symptome("toux persistante", 23)
    demander_symptome("tristesse persistante", 24)
    demander_symptome("hallucinations", 25)
    demander_symptome("épisodes maniaques", 26)
    demander_symptome("points noirs", 27)
    demander_symptome("démangeaisons cutanées", 28)
    demander_symptome("éruptions cutanées", 29)
    demander_symptome("plaques rouges épaisses", 30)
    demander_symptome("dépigmentation de la peau", 31)
    demander_symptome("éruption cutanée douloureuse", 32)
    demander_symptome("cloques groupées", 33)
    demander_symptome("vision brouillée", 34)
    demander_symptome("vision floue", 35)
    # demander_symptome("vision floue", 36)
    # demander_symptome("vision floue", 37)
    demander_symptome("douleur articulaire", 38)
    demander_symptome("douleur soutenue du bas du dos", 39)
    demander_symptome("douleur irradiante dans une jambe", 40)
    demander_symptome("douleur du bas du dos", 41)
    demander_symptome("douleur locale", 42)
    demander_symptome("fractures osseuses fréquentes", 43)
    demander_symptome("courbure anormale de la colonne vertébrale", 44)
    demander_symptome("fatigue excessive", 45)
    demander_symptome("douleur de tête constante ou récurrente", 46)
    demander_symptome("convulsions ou crises épileptiques", 47)
    demander_symptome("perte de mémoire", 48)
    # demander_symptome("perte de mémoire", 49)
    demander_symptome("engourdissement ou faiblesse d'un côté du corps", 50)
    demander_symptome("fatigue persistante", 51)
    demander_symptome("ganglions lymphatiques enflés", 52)
    demander_symptome("infections fréquentes", 53)

def poser_question_B(N):
    if N == 0:
        demander_symptome_B("essoufflement", N)
    elif N == 1:
        demander_symptome_B("essoufflement", N)
    elif N == 2:
        demander_symptome_B("fatigue", N)
        demander_symptome_B("toux chronique", 14)
    elif N == 3:
        demander_symptome_B("gonflement rougeur jambe", N)
    elif N == 4:
        demander_symptome_B("douleur thoracique", N)
    elif N == 5:
        demander_symptome_B("vertiges", N)
    elif N == 6:
        demander_symptome_B("battements cardiaques rapides lents", N)
    elif N == 7:
        demander_symptome_B("fatigue", N)
    elif N == 8:
        demander_symptome_B("augmentation appétit", N)
    elif N == 9:
        demander_symptome_B("augmentation appétit", N)
    elif N == 10:
        demander_symptome_B("prise poids inexpliquée", N)
        demander_symptome_B("jaunisse", 20)
    elif N == 11:
        demander_symptome_B("difficulté mouvements", N)
    elif N == 12:
        demander_symptome_B("oppression thoracique", N)
    elif N == 13:
        demander_symptome_B("essoufflement", N)
    elif N == 14:
        demander_symptome_B("toux chronique", N)
    elif N == 15:
        demander_symptome_B("somnolence diurne", N)
    elif N == 16:
        demander_symptome_B("toux", N)
        demander_symptome_B("fatigue", 19)
    elif N == 17:
        demander_symptome_B("éternuements fréquents", N)
        demander_symptome_B("douleur faciale", 18)
    elif N == 18:
        demander_symptome_B("douleur faciale", N)
    elif N == 19:
        demander_symptome_B("fatigue", N)
    elif N == 20:
        demander_symptome_B("jaunisse", N)
    elif N == 21:
        demander_symptome_B("jaunisse", N)
    elif N == 22:
        demander_symptome_B("fièvre", N)
    elif N == 23:
        demander_symptome_B("fièvre", N)
    elif N == 24:
        demander_symptome_B("perte intérêt activités", N)
    elif N == 25:
        demander_symptome_B("délires", N)
    elif N == 26:
        demander_symptome_B("épisodes dépressifs", N)
    elif N == 27:
        demander_symptome_B("boutons inflammatoires", N)
    elif N == 28:
        demander_symptome_B("rougeurs", N)
    elif N == 29:
        demander_symptome_B("démangeaisons intenses", N)
    elif N == 30:
        demander_symptome_B("desquamation", N)
    elif N == 31:
        demander_symptome_B("taches blanches", N)
    elif N == 32:
        demander_symptome_B("douleur locale intense", N)
    elif N == 33:
        demander_symptome_B("démangeaisons cutanées", N)
    elif N == 34:
        demander_symptome_B("vision périphérique réduite", N)
    elif N == 35:
        demander_symptome_B("sensibilité à la lumière", N)
        demander_symptome_B("vision déformée", 36)
        demander_symptome_B("vision déformée", 37)
    elif N == 36:
        demander_symptome_B("vision déformée", N)
    elif N == 37:
        demander_symptome_B("vision déformée", N)
    elif N == 38:
        demander_symptome_B("raideur articulaire", N)
    elif N == 39:
        demander_symptome_B("douleur irradiant dans les jambes", N)
    elif N == 40:
        demander_symptome_B("douleur aiguë dans les fesses ou les jambes", N)
    elif N == 41:
        demander_symptome_B("raideur du bas du dos", N)
    elif N == 42:
        demander_symptome_B("douleur augmentant avec activité", N)
    elif N == 43:
        demander_symptome_B("diminution de la taille", N)
    elif N == 44:
        demander_symptome_B("asymétrie des épaules ou des hanches", N)
    elif N == 45:
        demander_symptome_B("faiblesse musculaire", N)
    elif N == 46:
        demander_symptome_B("sensibilité à la lumière ou au bruit", N)
    elif N == 47:
        demander_symptome_B("perte de conscience ou absences", N)
    elif N == 48:
        demander_symptome_B("difficultés de langage", N)
    elif N == 49:
        demander_symptome_B("difficultés de langage", N)
    elif N == 50:
        demander_symptome_B("difficulté à parler ou à comprendre", N)
    elif N == 51:
        demander_symptome_B("perte de poids", N)
    elif N == 52:
        demander_symptome_B("sueurs nocturnes", N)
    elif N == 53:
        demander_symptome_B("infections graves ou récurrentes", N)

def poser_question_C(N):
    if N == 0:
        demander_symptome_C("transpiration excessive", N)
    elif N == 1:
        demander_symptome_C("fatigue", N)
    elif N == 2:
        demander_symptome_C("œdème jambes chevilles", N)
    elif N == 3:
        demander_symptome_C("chaleur au toucher", N)
    elif N == 4:
        demander_symptome_C("battements cardiaques rapides", N)
    elif N == 5:
        demander_symptome_C("essoufflement", N)
    elif N == 6:
        demander_symptome_C("étourdissements", N)
    elif N == 7:
        demander_symptome_C("palpitations cardiaques", N)
    elif N == 8:
        demander_symptome_C("mictions fréquentes", N)
    elif N == 9:
        demander_symptome_C("nervosité", N)
    elif N == 10:
        demander_symptome_C("frilosité", N)
    elif N == 11:
        demander_symptome_C("essoufflement", N)
    elif N == 12:
        demander_symptome_C("toux", N)
    elif N == 13:
        demander_symptome_C("fatigue", N)
    elif N == 14:
        demander_symptome_C("fatigue", N)
    elif N == 15:
        demander_symptome_C("fatigue", N)
    elif N == 16:
        demander_symptome_C("essoufflement", N)
    elif N == 17:
        demander_symptome_C("écoulement nasal postérieur", N)
    elif N == 18:
        demander_symptome_C("écoulement nasal postérieur", N)
    elif N == 19:
        demander_symptome_C("perte de poids inexpliquée", N)
    elif N == 20:
        demander_symptome_C("douleurs abdominales", N)
    # elif N == 21:
    #     demander_symptome_C("douleurs abdominales", N)
    elif N == 22:
        demander_symptome_C("fatigue", N)
    elif N == 23:
        demander_symptome_C("perte de poids inexpliquée", N)
    elif N == 24:
        demander_symptome_C("changements d'appétit", N)
    elif N == 25:
        demander_symptome_C("troubles de la pensée", N)
    elif N == 26:
        demander_symptome_C("fluctuations d'humeur", N)
    elif N == 27:
        demander_symptome_C("peau grasse", N)
    elif N == 28:
        demander_symptome_C("plaques sèches", N)
    elif N == 29:
        demander_symptome_C("plaques rouges", N)
    elif N == 30:
        demander_symptome_C("démangeaisons cutanées", N)
    elif N == 31:
        demander_symptome_C("perte de couleur des cheveux", N)
    elif N == 32:
        demander_symptome_C("picotements ou brûlures cutanées", N)
    elif N == 33:
        demander_symptome_C("sensation de brûlure", N)
    elif N == 34:
        demander_symptome_C("douleur oculaire", N)
    elif N == 35:
        demander_symptome_C("vision diminuée", N)
    elif N == 36:
        demander_symptome_C("vision diminuée", N)
    elif N == 37:
        demander_symptome_C("vision diminuée", N)
    elif N == 38:
        demander_symptome_C("enflure articulaire", N)
    elif N == 39:
        demander_symptome_C("engourdissement ou faiblesse des jambes", N)
    elif N == 40:
        demander_symptome_C("engourdissement ou faiblesse dans les jambes", N)
    elif N == 41:
        demander_symptome_C("douleur aggravant avec le mouvement", N)
    elif N == 42:
        demander_symptome_C("raideur des tissus mous", N)
    elif N == 43:
        demander_symptome_C("dos voûté", N)
    elif N == 44:
        demander_symptome_C("douleur du dos", N)
    elif N == 45:
        demander_symptome_C("troubles de l'équilibre et de la coordination", N)
    elif N == 46:
        demander_symptome_C("nausées ou vomissements", N)
    elif N == 47:
        demander_symptome_C("mouvements incontrôlés des membres", N)
    elif N == 48:
        demander_symptome_C("troubles d'orientation", N)
    # elif N == 49:
    #     demander_symptome_C("troubles d'orientation", N)
    elif N == 50:
        demander_symptome_C("troubles de la vision d'un côté", N)
    elif N == 51:
        demander_symptome_C("saignements anormaux", N)
    elif N == 52:
        demander_symptome_C("fièvre", N)
    elif N == 53:
        demander_symptome_C("guérison lente des infections", N)

def poser_question_D(N):
    if N == 0:
        demander_symptome_D("nausées et vomissements", N)
    elif N == 1:
        demander_symptome_D("douleurs irradiant des bras et de la mâchoire", N)
    elif N == 2:
        demander_symptome_D("prise de poids rapide", N)
    elif N == 3:
        demander_symptome_D("veines visibles et tendues", N)
    elif N == 4:
        demander_symptome_D("toux avec sang ou crachats sanglants", N)
    elif N == 5:
        demander_symptome_D("fatigue", N)
    elif N == 6:
        demander_symptome_D("évanouissement", N)
    elif N == 7:
        demander_symptome_D("gonflement des chevilles et des jambes", N)
    elif N == 8:
        demander_symptome_D("perte de poids inexpliquée", N)
    elif N == 9:
        demander_symptome_D("tremblements", N)
    elif N == 10:
        demander_symptome_D("peau sèche", N)
    elif N == 11:
        demander_symptome_D("fatigue", N)
    elif N == 12:
        demander_symptome_D("essoufflement", N)
    elif N == 13:
        demander_symptome_D("sensation d'oppression thoracique", N)
    elif N == 14:
        demander_symptome_D("perte de poids inexpliquée", N)
    elif N == 15:
        demander_symptome_D("réveils fréquents pendant la nuit", N)
    elif N == 16:
        demander_symptome_D("douleur thoracique", N)
    elif N == 17:
        demander_symptome_D("démangeaisons nasales", N)
    elif N == 18:
        demander_symptome_D("maux de tête", N)
    elif N == 19:
        demander_symptome_D("ganglions lymphatiques enflés", N)
    elif N == 20:
        demander_symptome_D("perte d'appétit", N)
        demander_symptome_D("urines foncées", 21)
    elif N == 21:
        demander_symptome_D("urines foncées", N)
    elif N == 22:
        demander_symptome_D("douleurs articulaires", N)
    elif N == 23:
        demander_symptome_D("fatigue", N)
    elif N == 24:
        demander_symptome_D("troubles du sommeil", N)
    elif N == 25:
        demander_symptome_D("retrait social", N)
    elif N == 26:
        demander_symptome_D("énergie excessive", N)
    elif N == 27:
        demander_symptome_D("cicatrices", N)
    elif N == 28:
        demander_symptome_D("desquamation", N)
    elif N == 29:
        demander_symptome_D("enflure cutanée", N)
    elif N == 30:
        demander_symptome_D("ongles épais ou cassants", N)
    elif N == 31:
        demander_symptome_D("sensibilité au soleil", N)
    elif N == 32:
        demander_symptome_D("sensibilité cutanée", N)
    elif N == 33:
        demander_symptome_D("douleur locale", N)
    elif N == 34:
        demander_symptome_D("vision tunnel", N)
    elif N == 35:
        demander_symptome_D("vision double", N)
    elif N == 36:
        demander_symptome_D("taches sombres dans le champ visuel", N)
    elif N == 37:
        demander_symptome_D("vision double", N)
    elif N == 38:
        demander_symptome_D("diminution de la mobilité articulaire", N)
    elif N == 39:
        demander_symptome_D("diminution de la sensation cutanée", N)
    elif N == 40:
        demander_symptome_D("sensation de picotements ou de brûlures", N)
    elif N == 41:
        demander_symptome_D("douleur aggravant avec l'effort physique", N)
    elif N == 42:
        demander_symptome_D("faiblesse musculaire locale", N)
    elif N == 43:
        demander_symptome_D("douleur osseuse", N)
    elif N == 44:
        demander_symptome_D("fatigue du dos lors de la position debout prolongée", N)
    elif N == 45:
        demander_symptome_D("problèmes de vision", N)
    elif N == 46:
        demander_symptome_D("troubles de la vision", N)
    elif N == 47:
        demander_symptome_D("sensations anormales ou aura épileptique", N)
    elif N == 48:
        demander_symptome_D("changements de comportement et d'humeur", N)
    elif N == 49:
        # demander_symptome_D("changements de comportement et humeur", N)
        pass
    elif N == 50:
        demander_symptome_D("perte de equilibre ou de la coordination", N)
    elif N == 51:
        demander_symptome_D("douleurs osseuses", N)
    elif N == 52:
        demander_symptome_D("perte de poids inexpliquee", N)
    elif N == 53:
        demander_symptome_D("infections opportunistes", N)


if __name__ == "__main__":
    main()
