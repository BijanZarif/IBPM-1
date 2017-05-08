function mats = assemble_B( parms, mats, soln )


display('Computing B...')

tic
%--Various variables 
    %# of x-vel (flux) points
    nu = get_velx_ind( parms.m-1, parms.n, parms.mg, parms );
    %# of y-vel (flux) points
    nv = get_vely_ind( parms.m, parms.n-1, parms.mg, parms );
    %Total # of vel (flux) points
    nq = nu + nv;
    %# of vort (circ) points
    ngam = get_vort_ind( parms.m-1, parms.n-1, parms.mg, parms );
    %# of body points
    nb = parms.nb;
    %# of surface stress points
    nf = nb * 2;
%--

%--specify matrices for ease in ensuing code

    C = mats.C; R = mats.R; M_vel = mats.M_vel; Lap = mats.Lap;
    Q = mats.Q; W = mats.W; ET = mats.ET; E = mats.E;
    I = mats.I; RC = mats.RC;

%--

ndof = ngam + 6*nb + nf;
mats.B = sparse( ndof, ndof ); 

%--(1,1) block

    B11 = R * C ;
    
    [i,j,s] = find( B11 );
    
    mats.B = mats.B + sparse( i,j,s, ndof, ndof );

%--

%--(2,2) block

    B22 = mats.M_flag;
    
    [i,j,s] = find( B22 );
    
    mats.B = mats.B + sparse( i+ngam,j+ngam,s, ndof, ndof );

%--

%--(3,3) block

    B33 = eye( size( mats.M_flag ) );
    
    [i,j,s] = find( B33 );
    
    mats.B = mats.B + sparse( i+ngam + 3*nb,j+ngam+ 3*nb,s, ndof, ndof );

%--


display('     done')


