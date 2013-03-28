//
//  MCOBJLoader.m
//  MCGame
//
//  Created by kwan terry on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MCOBJLoader.h"

@implementation MCOBJLoader

@synthesize m_vertexCount, m_vertexNormalCount, m_vertexTextureCount, m_faceCount;
@synthesize Cube_vertex_coordinates,Cube_normal_vectors,Cube_texture_coordinates;
@synthesize Cube_vertex_array_size;
@synthesize texture_key;



+(MCOBJLoader*)sharedMCOBJLoader
{
    static MCOBJLoader *sharedMCOBJLoader;
    @synchronized(self)
    {
        if (!sharedMCOBJLoader)
            sharedMCOBJLoader = [[MCOBJLoader alloc] init];
	}
	return sharedMCOBJLoader;
}

-(void)loadObjFromFile:(NSString*)filename objkey:(NSString*)objkey {
    vector<float> vertexs;
    vector<float> vertexNormals;
    vector<float> vertexTextures;
    vector<int> faces;
    
    
    [self getAllCount:filename];
    
    vertexs.resize(m_vertexCount * 3);
    vertexNormals.resize(m_vertexNormalCount *3);
    vertexTextures.resize(m_vertexTextureCount *2);
    faces.resize(m_faceCount * 9);
    
    float * v_ptr = &vertexs[0];
    float * vn_ptr = &vertexNormals[0];
    float * vt_ptr = &vertexTextures[0];
    int * faces_ptr = &faces[0];
    //Vertex* vertex = (Vertex*) &floats[0];
    ifstream objFile([filename UTF8String]);
    while (objFile) {
        string c;
        objFile >> c;
        if (c == "v") {
            objFile >> *(v_ptr++) >> *(v_ptr++) >> *(v_ptr++);
        }
        else{
            if(c == "vn"){
                objFile >> *(vn_ptr++) >> *(vn_ptr++) >> *(vn_ptr++);
            }
            else{
                if(c == "vt"){
                    objFile >> *(vt_ptr++) >> *(vt_ptr++);
                }
                else{
                    if(c == "f"){
                        char d ;
                        
                        objFile >> *(faces_ptr++) >> d >> *(faces_ptr++) >> d >> *(faces_ptr++);
                        objFile >> *(faces_ptr++) >> d >> *(faces_ptr++) >> d >> *(faces_ptr++);
                        objFile >> *(faces_ptr++) >> d >> *(faces_ptr++) >> d >> *(faces_ptr++);
                    }
                }
            }
        }
        objFile.ignore(80, '\n');
    }
    
    
    
    Cube_vertex_array_size = m_faceCount*3;
    Cube_vertex_coordinates = new float[Cube_vertex_array_size * 3];
    Cube_normal_vectors = new float[Cube_vertex_array_size*3];
    Cube_texture_coordinates = new float[Cube_vertex_array_size*2];
    //Cube_vertex_coordinates.resize(Cube_vertex_array_size*3);
    //Cube_normal_vectors.resize(Cube_vertex_array_size*3);
    //Cube_texture_coordinates.resize(Cube_vertex_array_size*2);
    
    for (int i = 0; i < m_faceCount; i++) {
        Cube_vertex_coordinates[i*9] = vertexs[(faces[i*9]-1)*3];
        Cube_vertex_coordinates[i*9+1] = vertexs[(faces[i*9]-1)*3+1];
        Cube_vertex_coordinates[i*9+2] = vertexs[(faces[i*9]-1)*3+2];
        
        Cube_texture_coordinates[i*6] = vertexTextures[(faces[i*9+1]-1)*2];
        Cube_texture_coordinates[i*6+1] = vertexTextures[(faces[i*9+1]-1)*2+1];
        Cube_normal_vectors[i*9] = vertexNormals[(faces[i*9+2]-1)*3];
        Cube_normal_vectors[i*9+1] = vertexNormals[(faces[i*9+2]-1)*3+1];
        Cube_normal_vectors[i*9+2] = vertexNormals[(faces[i*9+2]-1)*3+2];
        
        Cube_vertex_coordinates[i*9+3] = vertexs[(faces[i*9+3]-1)*3];
        Cube_vertex_coordinates[i*9+4] = vertexs[(faces[i*9+3]-1)*3+1];
        Cube_vertex_coordinates[i*9+5] = vertexs[(faces[i*9+3]-1)*3+2];
        Cube_texture_coordinates[i*6+2] = vertexTextures[(faces[i*9+4]-1)*2];
        Cube_texture_coordinates[i*6+3] = vertexTextures[(faces[i*9+4]-1)*2+1];
        Cube_normal_vectors[i*9+3] = vertexNormals[(faces[i*9+5]-1)*3];
        Cube_normal_vectors[i*9+4] = vertexNormals[(faces[i*9+5]-1)*3+1];
        Cube_normal_vectors[i*9+5] = vertexNormals[(faces[i*9+5]-1)*3+2];
        
        Cube_vertex_coordinates[i*9+6] = vertexs[(faces[i*9+6]-1)*3];
        Cube_vertex_coordinates[i*9+7] = vertexs[(faces[i*9+6]-1)*3+1];
        Cube_vertex_coordinates[i*9+8] = vertexs[(faces[i*9+6]-1)*3+2];
        Cube_texture_coordinates[i*6+4] = vertexTextures[(faces[i*9+7]-1)*2];
        Cube_texture_coordinates[i*6+5] = vertexTextures[(faces[i*9+7]-1)*2+1];
        Cube_normal_vectors[i*9+6] = vertexNormals[(faces[i*9+8]-1)*3];
        Cube_normal_vectors[i*9+7] = vertexNormals[(faces[i*9+8]-1)*3+1];
        Cube_normal_vectors[i*9+8] = vertexNormals[(faces[i*9+8]-1)*3+2];
    }
    
}

-(void) getAllCount:(NSString*)filename
{
    ifstream objFile([filename UTF8String]);
    while (objFile) {
        string c;
        objFile >> c;
        if (c == "v"){
            m_vertexCount++;
        }
        else{
            if(c == "vn"){
                m_vertexNormalCount++;
            }
            else{
                if(c == "vt"){
                    m_vertexTextureCount++;
                }
                else{
                    if(c == "f"){
                        m_faceCount++;
                    }
                }
            }
        }
            
        objFile.ignore(MaxLineSize, '\n');
    }
}

@end
