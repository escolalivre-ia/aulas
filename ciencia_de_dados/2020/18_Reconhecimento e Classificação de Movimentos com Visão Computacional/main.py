import numpy as np
import cv2
import imutils
from sklearn.neighbors import KNeighborsClassifier
import joblib

escala = 3
historico = []
threshold = 50
inferencia = False


count_0 = 0
count_1 = 0
count_2 = 0
count_3 = 0
count_4 = 0

model = KNeighborsClassifier(n_neighbors=5)
labels = ['-', 'Sim','Nao','Horario','Anti-horario']

cap = cv2.VideoCapture(0)


ret, frame = cap.read()
frame = cv2.resize(frame, None, fx=1/escala, fy=1/escala) 


prvs = cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY)



hsv = np.zeros_like(frame)
hsv[...,1] = 255

x = []
y = []


def get_flow(prvs,next):
    flow = cv2.calcOpticalFlowFarneback(prvs,next, None, .1, 3, 5, 1, 5, 2, 1)   
    mag, ang = cv2.cartToPolar(flow[...,0], flow[...,1])
    hsv[...,0] = ang*180/np.pi/2
    hsv[...,2] = cv2.normalize(mag,None,0,255,cv2.NORM_MINMAX)
    bgr = cv2.cvtColor(hsv,cv2.COLOR_HSV2BGR)
    return bgr
    
    
def get_strip(historico):
    strip = np.array(historico)
    strip = strip.reshape(bgr.shape[0]*20, bgr.shape[1],3)
    strip = imutils.resize(strip, height=frame.shape[0])
    return strip

while True:
    ret, frame = cap.read()
    frame = cv2.flip(frame,1)
    
    frame_copy = cv2.resize(frame, None, fx=1/escala, fy=1/escala)

    next = cv2.cvtColor(frame_copy,cv2.COLOR_BGR2GRAY)
    bgr = get_flow(prvs,next)
    bgr = np.where(bgr > threshold, bgr,0)
    historico.append(bgr)
    historico = historico[-20:]
    
    if len(historico) >= 20:
        strip = get_strip(historico)
        if inferencia:
            pred = model.predict(strip.reshape(1,-1))
            cv2.putText(frame, labels[int(pred)], (30,30), cv2.FONT_HERSHEY_SIMPLEX ,.9, (0,255,255),2, cv2.LINE_AA)
    bgr = cv2.resize(bgr, None, fx=1 * escala, fy = 1 * escala)  
    out = cv2.hconcat([frame,bgr])
    
    if len(historico) ==20:
        out = cv2.hconcat([out,strip])

    cv2.imshow('Resultado',out)
    
    k = cv2.waitKey(30)
    
    if k == ord('0'):
        count_0 += 1
        print("Item adicionado à classe {} - total {}".format(labels[0],count_0)) 
        x.append(strip)
        y.append(0)
        
    if k == ord('1'):
        count_1 += 1
        print("Item adicionado à classe {} - total {}".format(labels[1],count_1 )) 
        x.append(strip)
        y.append(1)

    if k == ord('2'):
        count_2 += 1
        print("Item adicionado à classe {} - total {}".format(labels[2],count_2)) 
        x.append(strip)
        y.append(2)

    if k == ord('3'):
        count_3 += 1
        print("Item adicionado à classe {} - total {}".format(labels[3],count_3)) 
        x.append(strip)
        y.append(3)

    if k == ord('4'):
        count_4 += 1
        print("Item adicionado à classe {} - total {}".format(labels[4],count_0)) 
        x.append(strip)
        y.append(4)

    if k == ord('t'):
    	print("Treinando Modelo KNN")
    	X = np.array(x)
    	X = X.reshape(len(y),-1)
    	model.fit(X,y)
    	print("Modelo treinado com sucesso!")
    	joblib.dump(model,'modelo.pkl')
    	print("Modelo salvo com sucesso!")
        
    if k == ord('r'):
        print("Carregando modelo")
        model = joblib.load('modelo.pkl')
        inferencia = True
        
    if k == ord('q'):
        cap.release()
        break

    prvs = next
